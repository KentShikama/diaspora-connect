class DiasporaConnect
  constructor: (@client_id, @redirect_uri, user_handler) ->
    @pod_url = "https://" + user_handler.split("@")[1]
    @user_info_endpoint = "#{@pod_url}/api/openid_connect/user_info"
    @access_token = ""
    @code = ""
    @id_token = ""

    client_info = {
      client_id : this.client_id,
      redirect_uri : this.redirect_uri
    };

    OIDC.setClientInfo(client_info)

    provider_info = OIDC.discover(@pod_url)

    OIDC.setProviderInfo(provider_info)
    OIDC.storeInfo(provider_info, client_info)

  login: () ->
    OIDC.login({
      scope : 'openid read write',
      response_type : 'id_token token',
      max_age : 60
    });

  get_tokens: () ->
    OIDC.restoreInfo()
    @id_token = OIDC.getValidIdToken()
    @code = OIDC.getCode()
    @access_token = OIDC.getAccessToken()

window.onload = () ->
  button = document.getElementById("diaspora-connect")
  if button == null
    log.error("Nobutton present")
    return

  redirect_uri = button.getAttribute("data-redirect-uri")
  diaspora_client = new DiasporaConnect "79af8f42ba5f43b73983f33becb4e5be", redirect_uri, "testaccount@kentshikama.com"
  diaspora_client.login()
  diaspora_client.get_tokens()