//
//  Plist.swift
//
//  Created by Jonathan Guthrie on 2016-08-24.
//
//

/*
Example Usage:

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

*/



import Foundation
import PerfectLib

public struct Plist {

	public enum PlistError: Error {
		case FileNotWritten
		case FileDoesNotExist
	}

	let name:String

	public init?(name:String) {

		self.name = name

		let thisFile = File("\(name).plist")
		if thisFile.exists == false {
			print("Settings file does not exist")
		}
	}

	public func getValuesInPlistFile() -> NSDictionary?{
		let thisFile = File("\(name).plist")

		if thisFile.exists {
			guard let dict = NSDictionary(contentsOfFile: thisFile.realPath) else {
				return .none
			}
			return dict
		} else {
			return .none
		}
	}

	public func getMutablePlistFile() -> NSMutableDictionary?{
		let thisFile = File("\(name).plist")

		if thisFile.exists {
			guard let dict = NSMutableDictionary(contentsOfFile: thisFile.realPath) else {
				return .none
			}
			return dict
		} else {
			return .none
		}
	}

	public func addValuesToPlistFile(dictionary:NSDictionary) throws {
		let thisFile = File("\(name).plist")

		if thisFile.exists {
			if !dictionary.write(toFile: thisFile.realPath, atomically: false) {
				print("File not written successfully")
				throw PlistError.FileNotWritten
			}
		} else {
			throw PlistError.FileDoesNotExist
		}
	}
}
