package com.shushper.flutter_passkey.flutter_passkey

import android.app.Activity
import android.content.Intent
import android.util.Base64
import android.util.Log
import androidx.annotation.NonNull
import com.google.android.gms.fido.Fido
import com.google.android.gms.fido.fido2.api.common.Attachment
import com.google.android.gms.fido.fido2.api.common.AuthenticatorAssertionResponse
import com.google.android.gms.fido.fido2.api.common.AuthenticatorAttestationResponse
import com.google.android.gms.fido.fido2.api.common.AuthenticatorSelectionCriteria
import com.google.android.gms.fido.fido2.api.common.EC2Algorithm
import com.google.android.gms.fido.fido2.api.common.PublicKeyCredentialCreationOptions
import com.google.android.gms.fido.fido2.api.common.PublicKeyCredentialDescriptor
import com.google.android.gms.fido.fido2.api.common.PublicKeyCredentialParameters
import com.google.android.gms.fido.fido2.api.common.PublicKeyCredentialRequestOptions
import com.google.android.gms.fido.fido2.api.common.PublicKeyCredentialRpEntity
import com.google.android.gms.fido.fido2.api.common.PublicKeyCredentialType
import com.google.android.gms.fido.fido2.api.common.PublicKeyCredentialUserEntity
import com.google.android.gms.fido.fido2.api.common.ResidentKeyRequirement
import io.flutter.embedding.android.FlutterFragmentActivity

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import org.json.JSONObject

/** FlutterPasskeyPlugin */
class FlutterPasskeyPlugin : FlutterPlugin, MethodCallHandler, ActivityAware,
  PluginRegistry.ActivityResultListener {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel: MethodChannel
  private var activity: Activity? = null
  private var getCredentialResult: Result? = null
  private var createCredentialResult: Result? = null

  companion object {
    private const val TAG = "FlutterPasskeyPlugin"
    private const val GET_CREDENTIAL_REQUEST_CODE = 1
    private const val CREATE_CREDENTIAL_REQUEST_CODE = 2
  }


  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(
      flutterPluginBinding.binaryMessenger,
      "flutter_passkey"
    )
    channel.setMethodCallHandler(this)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
    binding.addActivityResultListener(this)
  }

  override fun onDetachedFromActivity() {
    activity = null
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
    binding.addActivityResultListener(this)
  }


  override fun onMethodCall(
    call: MethodCall,
    result: Result
  ) {
    when (call.method) {
      "getPlatformVersion" -> result.success(getPlatformVersion())
      "createCredential" -> {
        createCredentialResult = result;
        val options = call.argument("options") as String?
        if (options == null) {
          result.error(
            "InvalidParameterException",
            "Options not found",
            null
          )
          return
        }
        try {
          createCredential(options)
        } catch (e: Exception) {
          result.error(
            e.javaClass.kotlin.simpleName ?: "Exception",
            e.message
              ?: "Exception occurred while creating credential",
            null
          )
        }
      }

      "getCredential" -> {
        getCredentialResult = result
        val options = call.argument("options") as String?
        if (options == null) {
          result.error(
            "InvalidParameterException",
            "Options not found",
            null
          )
          return
        }
        try {
          getCredential(options)
        } catch (e: Exception) {
          result.error(
            e.javaClass.kotlin.simpleName ?: "Exception",
            e.message
              ?: "Exception occurred while getting credential",
            null
          )
        }
      }

      else -> result.notImplemented()
    }
  }

  private fun getPlatformVersion(): String {
    return "Android ${android.os.Build.VERSION.RELEASE}"
  }

  private fun getCredential(options: String) {
    Log.d(TAG, "getCredential")

    val context =
      activity ?: throw IllegalStateException("Activity not found")

    val jsonObj = JSONObject(options)
    val challengeString = jsonObj.getString("challenge")
    val byteArray = if (isBase64UrlEncoded(challengeString)) {
      decodeBase64Url(challengeString)
    } else {
      challengeString.toByteArray()
    }
    val allowedCredentials = jsonObj.getJSONArray("allowCredentials")
    val publicKeys = ArrayList<PublicKeyCredentialDescriptor>()
    for (i in 0 until allowedCredentials.length()) {
      val cred = allowedCredentials.getJSONObject(i)
      val idString = cred.getString("id")
      val id = if (isBase64UrlEncoded(idString)) {
        decodeBase64Url(idString)
      } else {
        idString.toByteArray()
      }
      publicKeys.add(
        element = PublicKeyCredentialDescriptor(
          cred.getString("type"),
          id,
          null,
        )

      )
    }

    val requestOptions = PublicKeyCredentialRequestOptions.Builder()
      .setChallenge(byteArray)
      .setRpId(jsonObj.getString("rpId"))
      .setAllowList(publicKeys)
      .setTimeoutSeconds(jsonObj.getDouble("timeout"))
      .build()

    val fido2ApiClient = Fido.getFido2ApiClient(context)
    val task = fido2ApiClient.getSignPendingIntent(requestOptions)

    task.addOnSuccessListener { pendingIntent ->

      if (pendingIntent != null) {
        Log.d(TAG, "startIntentSenderForResult")
        // Start a FIDO2 sign request.
        activity!!.startIntentSenderForResult(
          pendingIntent.intentSender,
          GET_CREDENTIAL_REQUEST_CODE,
          null, // fillInIntent
          0, // flagsMask
          0, // flagsValue
          0 // extraFlags
        )
      }
    }
    task.addOnFailureListener { e ->
      getCredentialResult?.error(
        "Getting pending intent failure",
        "Getting pending intent failure",
        null,
      )
    }
  }


  private fun createCredential(
    options: String
  ) {

    Log.d(TAG, "createCredential")

    val context =
      activity ?: throw IllegalStateException("Activity not found")

    val jsonObj = JSONObject(options)

    val challengeString = jsonObj.getString("challenge")
    val byteArray = if (isBase64UrlEncoded(challengeString)) {
      decodeBase64Url(challengeString)
    } else {
      challengeString.toByteArray()
    }

    val rp = jsonObj.getJSONObject("rp")
    val rpId = rp.getString("id")
    val rpName = rp.getString("name")

    val user = jsonObj.getJSONObject("user")
    val userName = user.getString("name")
    val displayName = user.getString("displayName")
    val id = user.getString("id")

    val authenticatorSelection =
      jsonObj.getJSONObject("authenticatorSelection")
    val authenticatorAttachment =
      authenticatorSelection.getString("authenticatorAttachment")
    val userVerification =
      authenticatorSelection.getString("userVerification")

    val timeout = jsonObj.getDouble("timeout")

    val pubKeyCredParams = jsonObj.getJSONArray("pubKeyCredParams")
    val publicKeys = ArrayList<PublicKeyCredentialParameters>()

    for (i in 0 until pubKeyCredParams.length()) {
      val param = pubKeyCredParams.getJSONObject(i)
      val type = param.getString("type")
      val algorithm = param.getInt("alg")

      publicKeys.add(
        element = PublicKeyCredentialParameters(
          type,
          algorithm,
        )
      )
    }

    val creationOptions = PublicKeyCredentialCreationOptions.Builder()
      .setChallenge(byteArray)
      .setRp(
        PublicKeyCredentialRpEntity(
          rpId,
          rpName,
          null,
        )
      )
      .setUser(
        PublicKeyCredentialUserEntity(
          id.toByteArray(),
          userName,
          "",
          displayName,
        )
      )
      .setAuthenticatorSelection(
        AuthenticatorSelectionCriteria.Builder()
          .setAttachment(
            Attachment.fromString(authenticatorAttachment)
          )
          .setResidentKeyRequirement(
            ResidentKeyRequirement.fromString(
              userVerification
            )
          )
          .build()
      )
      .setTimeoutSeconds(timeout)
      .setParameters(publicKeys)
      .build()


    Log.d(TAG, "creation options ready")

    val fido2ApiClient = Fido.getFido2ApiClient(context)
    val fido2PendingIntentTask =
      fido2ApiClient.getRegisterPendingIntent(creationOptions)

    Log.d(TAG, "task set success listener")

    fido2PendingIntentTask.addOnSuccessListener { pendingIntent ->

      if (pendingIntent != null) {
        Log.d(TAG, "startIntentSenderForResult")
        // Start a FIDO2 sign request.
        activity!!.startIntentSenderForResult(
          pendingIntent.intentSender,
          CREATE_CREDENTIAL_REQUEST_CODE,
          null, // fillInIntent
          0, // flagsMask
          0, // flagsValue
          0 // extraFlags
        )
      }
    }

    Log.d(TAG, "task set failure listener")

    fido2PendingIntentTask.addOnFailureListener { e ->
      createCredentialResult?.error(
        "Creating pending intent failure",
        "Creating pending intent failure",
        null,
      )
    }
  }


  private fun decodeBase64Url(encoded: String): ByteArray {
    return Base64.decode(encoded, Base64.URL_SAFE)
  }

  private fun isBase64UrlEncoded(input: String): Boolean {
    return try {
      Base64.decode(input, Base64.URL_SAFE)
      true
    } catch (e: IllegalArgumentException) {
      false
    }
  }

  override fun onActivityResult(
    requestCode: Int,
    resultCode: Int,
    data: Intent?
  ): Boolean {
    Log.d(TAG, "onActivityResult")
    when (requestCode) {
      GET_CREDENTIAL_REQUEST_CODE -> {
        handleGetCredentialActivityResult(resultCode, data)
      }

      CREATE_CREDENTIAL_REQUEST_CODE -> {
        handleCreateCredentialActivityResult(resultCode, data)
      }
    }
    return false
  }


  private fun handleGetCredentialActivityResult(
    resultCode: Int,
    data: Intent?
  ) {
    Log.d(TAG, "handleGetCredentialActivityResult")
    when (resultCode) {
      FlutterFragmentActivity.RESULT_OK -> {
        data?.let {
          if (it.hasExtra(Fido.FIDO2_KEY_CREDENTIAL_EXTRA)) {
            val response =
              data.getByteArrayExtra(Fido.FIDO2_KEY_CREDENTIAL_EXTRA)
            try {
              val credential =
                parseGetCredentialsResponse(response!!)
              getCredentialResult?.success(credential)
            } catch (e: Exception) {
              getCredentialResult?.error(
                "Failure to parse fido 2 response",
                "Failure to parse fido 2 response",
                null
              )
            }

          }
        }
      }

      FlutterFragmentActivity.RESULT_CANCELED -> {
        getCredentialResult?.error(
          "RESULT_CANCELED",
          "Operation is canceled",
          null
        )
      }

      else -> {
        getCredentialResult?.error(
          "FAILED",
          "Operation failed, with resultCode: $resultCode",
          null
        )
      }
    }
  }

  private fun handleCreateCredentialActivityResult(
    resultCode: Int,
    data: Intent?
  ) {
    Log.d(TAG, "handleCreateCredentialActivityResult")
    when (resultCode) {
      FlutterFragmentActivity.RESULT_OK -> {

        data?.let {
          if (it.hasExtra(Fido.FIDO2_KEY_CREDENTIAL_EXTRA)) {
            val response =
              data.getByteArrayExtra(Fido.FIDO2_KEY_CREDENTIAL_EXTRA)

            try {
              val credential =
                parseCreateCredentialsResponse(response!!)
              createCredentialResult?.success(credential)
            } catch (e: Exception) {
              createCredentialResult?.error(
                "Failure to parse fido 2 response",
                "Failure to parse fido 2 response",
                null
              )
            }
          }
        }
      }

      FlutterFragmentActivity.RESULT_CANCELED -> {
        createCredentialResult?.error(
          "RESULT_CANCELED",
          "Operation is canceled",
          null
        )
      }

      else -> {
        createCredentialResult?.error(
          "FAILED",
          "Operation failed, with resultCode: $resultCode",
          null
        )
      }
    }

  }

  private fun parseGetCredentialsResponse(fido2Response: ByteArray): String {

    val res =
      com.google.android.gms.fido.fido2.api.common.PublicKeyCredential.deserializeFromBytes(
        fido2Response
      )
    val response = res.response as AuthenticatorAssertionResponse

    val keyHandleBase64 = Base64.encodeToString(
      res.rawId,
      Base64.URL_SAFE or Base64.NO_PADDING or Base64.NO_WRAP
    )
    val clientDataObj =
      JSONObject(String(response.clientDataJSON, Charsets.UTF_8))
    val clientDataJson = Base64.encodeToString(
      clientDataObj.toString().toByteArray(),
      Base64.URL_SAFE or Base64.NO_PADDING or Base64.NO_WRAP
    )
    val authenticatorDataBase64 =
      Base64.encodeToString(
        response.authenticatorData,
        Base64.URL_SAFE or Base64.NO_PADDING or Base64.NO_WRAP
      )
    val signatureBase64 = Base64.encodeToString(
      response.signature,
      Base64.URL_SAFE or Base64.NO_PADDING or Base64.NO_WRAP
    )

    Log.d(TAG, "keyHandleBase64: $keyHandleBase64")
    Log.d(TAG, "clientDataJSON: $clientDataJson")
    Log.d(TAG, "authenticatorDataBase64: $authenticatorDataBase64")
    Log.d(TAG, "signatureBase64: $signatureBase64")

    val jsonResult = JSONObject()
    val jsonResponse = JSONObject()
    jsonResponse.put("authenticatorData", authenticatorDataBase64)
    jsonResponse.put("signature", signatureBase64)
    jsonResponse.put("clientDataJSON", clientDataJson)
    jsonResponse.put("userHandle", "")
    jsonResult.put("id", keyHandleBase64)
    jsonResult.put("rawId", keyHandleBase64)
    jsonResult.put("type", "public-key")
    jsonResult.put("response", jsonResponse)

    return jsonResult.toString()

  }

  private fun parseCreateCredentialsResponse(fido2Response: ByteArray): String {
    val res =
      com.google.android.gms.fido.fido2.api.common.PublicKeyCredential.deserializeFromBytes(
        fido2Response
      )

    val response = res.response as AuthenticatorAttestationResponse

    val keyHandleBase64 = Base64.encodeToString(
      res.rawId,
      Base64.URL_SAFE or Base64.NO_PADDING or Base64.NO_WRAP
    )

    val clientDataJson = Base64.encodeToString(
      response.clientDataJSON,
      Base64.URL_SAFE or Base64.NO_PADDING or Base64.NO_WRAP
    )
    val attestationObjectBase64 = Base64.encodeToString(
      response.attestationObject,
      Base64.URL_SAFE or Base64.NO_PADDING or Base64.NO_WRAP
    )

    Log.d(TAG, "keyHandleBase64: $keyHandleBase64")
    Log.d(TAG, "clientDataJSON: $clientDataJson")
    Log.d(TAG, "attestationObjectBase64: $attestationObjectBase64")


    val jsonResult = JSONObject()
    val jsonResponse = JSONObject()
    jsonResponse.put("attestationObject", attestationObjectBase64)
    jsonResponse.put("clientDataJSON", clientDataJson)
    jsonResult.put("id", keyHandleBase64)
    jsonResult.put("rawId", keyHandleBase64)
    jsonResult.put("type", "public-key")
    jsonResult.put("response", jsonResponse)

    return jsonResult.toString()
  }
}
