# This script is largely copied from 
# https://github.com/hadley/httr/blob/master/demo/oauth2-github.r

library (httr)
library(rjson)
library(jsonlite)

# Set up oauth
myapp <- oauth_app("GACD_Q2",
				   key = "",
				   secret = "")

# get oauth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp, cache=FALSE)

# use api
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/repos/jtleek/datasharing", gtoken)
json1 <- content(req)
json2 = jsonlite::fromJSON(toJSON(json1))

print(json2$created_at[1])
