#!/usr/bin/env bash
# This is an example of using curl against the REST API

openam="${INSTANCE}"

echo "Custom-configuring $openam using the OpenAM REST API"

# Authenticate to OpenAM and obtain SSO token for subsequent calls
ssoToken=$(curl -s -X POST -H "Content-Type: application/json" \
  -H "X-OpenAM-Username: amadmin" -H "X-OpenAM-Password: password" \
  -d '{}' "${openam}/json/authenticate" | sed -e 's/^.*"tokenId"[ ]*:[ ]*"//' -e 's/".*//')

function post {
  echo "post: $2"
  echo "data: $1"
  curl -s -X POST -H "Content-Type: application/json" -H "iPlanetDirectoryPro: ${ssoToken}" -d "$1" "$2"
}

# Example: enable OAuth2 / OIDC
post '{}' "${openam}/json/realm-config/services/oauth-oidc?_action=create&_prettyPrint=true"

# Example: create a realm
realm=testrealm
post '{"name":"'${realm}'","parentPath":"/","aliases":[],"active":true,"statelessSessionsEnabled":false}'  \
   "${openam}/json/global-config/realms?_action=create&_prettyPrint=true"


# Example: create an OAuth2 client
client=oauthtest
post '{"username":"'${client}'", "AgentType": "OAuth2Client", "userpassword": "password", "com.forgerock.openam.oauth2provider.redirectionURIs": [], "com.forgerock.openam.oauth2provider.scopes": ["[0]=openid"], "com.forgerock.openam.oauth2provider.defaultScopes": [], "com.forgerock.openam.oauth2provider.tokenEndPointAuthMethod": "client_secret_post"}'  \
 "${openam}/json/agents?_action=create&_prettyPrint=true"


# Test OAuth2
# Not working - todo: find out why
# post 'grant_type=password&username=demo&password=changeit&client_id='${client}'&client_secret=password&scope=openid' \
     "${openam}/oauth2/access_token"


