# Swifty-pList

A Swift 3 pList library. Reads &amp; writes pLists for server side configuration.

Plist files can be used for maintaining system specific settings such as database names, credentials, api keys, access tokens.
It makes no sense to include these in compiled binaries as they will vary between development, staging and deployment environments, 
or between distributions.

### Setup

Include the Swifty-pList dependancy in your project's Package.swift file:

``` swift
 .Package(url: "https://github.com/iamjono/Swifty-pList.git", majorVersion: 0, minor: 1)
```

After changing your Package.swift file, remember to rebuild your Xcode project:

```
swift package generate-xcodeproj
```

Open your project, and add a new pList file, and add the property key-value pairs in the same way as is seen in the example 
[ApplicationConfiguration.plist](https://github.com/iamjono/Swifty-pList/blob/master/ApplicationConfiguration.plist).

In the "Build Phases" for your target binary, add a "Copy Files" phase if one does not already exist. 
Add your plist file to the file list, with a destination of "Resources". 
When you build your project within Xcode this plist file will be copied next to your executable binary.

When deploying on a server, make sure the plist file is in the same relative position, and change the values to those appropriate to the system.

### Example usage:

``` swift
func GetAPIKey() -> AppCredentials {
	var creds = AppCredentials()
	if let plist = Plist(name: "ApplicationConfiguration") {

		let dict = plist.getMutablePlistFile()!

		creds.clientid = dict["clientid"] as! String
		creds.clientsecret = dict["clientid"] as! String

		if creds.clientid.characters.count > 0 {
			return creds
		} else {
			print("No API Key")
		}
	} else {
		print("Unable to get Plist")
	}
	return creds
}

func GetAPIToken() -> String {
	var token = ""
	if let plist = Plist(name: "ApplicationConfiguration") {

		let dict = plist.getMutablePlistFile()!

		token = dict["token"] as! String

		if token.characters.count > 0 {
			return token
		} else {
			print("No API Key")
		}
	} else {
		print("Unable to get Plist")
	}
	return token
}
```
