<cfscript>
    files = [
        "https://repo1.maven.org/maven2/org/apache/poi/poi-ooxml/5.3.0/poi-ooxml-5.3.0.jar",
        "https://repo1.maven.org/maven2/org/apache/poi/poi/5.3.0/poi-5.3.0.jar"
    ];

    lex=  "https://ext.lucee.org/poi-extension-1.0.0.6-BETA.lex";

    dir = getDirectoryFromPath(getCurrentTemplatePath()) & "poi-ext";
    directoryCreate( dir );
/*
    for ( fileUrl in files ){
        http url=fileUrl path=dir file=ListLast( fileUrl,"/ ");
    }

    */

    http url=lex path=getTempDirectory() file="poi.lex";

    extract( "zip", getTempDirectory() & "poi.lex", dir );

    files = directoryList( dir, true );
    systemOutput( files );

    contextLibDir = ExpandPath('{lucee-config}') & "/lib";

    for ( file in files ){
        if ( listLast( file, ".") eq "jar" && listLast( file, "/") contains "poi-" ){
            systemOutput( "copying [#file#] to [#contextLibDir#]", true );
            fileCopy( file, contextLibDir );
        }
    }
    contextLibDir = ExpandPath('{lucee-config}') & "/lib";

    files = directoryList( contextLibDir, true );
    systemOutput( files );


</cfscript>
