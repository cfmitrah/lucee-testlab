<cfscript>

	systemOutput( "--- Bundle Test ---- " );
	systemOutput( "--- extensions are loaded on demand, so let's trigger them ---- " );
	systemOutput( "", true );

	systemOutput( "ESAPI", true );
	encodeForHTML( "lucee" );

	systemOutput( "", true );
	systemOutput( "CFZIP", true );
	file = getTempFile(getTempDirectory(), "test", "text" );
	zip action="zip" source="#file#" file="#getTempFile(getTempDirectory(), "test", "zip")#";

	systemOutput( "", true );
	systemOutput( "PDF", true );
	isPDFObject( file );

	systemOutput( "", true );
	systemOutput( "S3", true );
	s3exists( bucketName="extension-download", objectName="test", accessKeyId="test", secretAccessKey="test" ); // will throw

	/* 
	broken
	systemOutput( "", true );
	systemOutput( "Argon", true );
	generateArgon2Hash( "lucee" );
	*/

	systemOutput( "", true );
	systemOutput( "writing password to #expandPath('{lucee-config}/password.txt')#", true );
	fileWrite( expandPath('{lucee-config}/password.txt'), "lucee" );

	admin
		action="checkPassword"
		type="server";

	/*
	admin
			action="updatePassword"
			type="server"
			oldPassword=""
			newPassword="lucee";
	*/
	
	admin
		type="server"
			password="lucee"
			action="getBundles"
			returnvariable="bundles";
	for ( bundle in bundles ){
		systemOutput( "#chr(9)# #bundle.symbolicName#, #bundles.version#, #bundles.state#", true );
	}
	systemOutput( "--- finished ---- " );
</cfscript>