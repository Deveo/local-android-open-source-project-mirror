# Setup local Android open source project mirror

This is a working example for how to set up local [Android open source project](https://source.android.com/) mirror using [Deveo](https://deveo.com). Deveo is a code hosting and collaboration platform that you may install on-premises and host android open source project without any modifications to the manifest.xml or any other files. The solution utilizes XSLT as a tool of choice for the problem. The approach is described more thoroughly in [this blog post](http://blog.deveo.com/how-to-create-local-android-open-source-project-mirror/
).

## Instructions

To generate the setup "script", run

```
xsltproc --stringparam ANDROID_URL android.googlesource.com \
--stringparam DEVEO_URL app.deveo.com \
--stringparam DEVEO_PROJECT aosp-test-mirror \
--stringparam PLUGIN_KEY 3a12d59d6220aa024cb45b8c7b82db12 \
--stringparam COMPANY_KEY c18c6317641b13223228b1cd7254e9b8 \
--stringparam ACCOUNT_KEY 462c0f154875824a626c81a26ab3212f \
--stringparam DEVEO_COMPANY deveo \
--stringparam DEVEO_USERNAME ilmarideveocom manifest.xsl test-manifest.xml > output.sh
```

replace the parameters with your own values, and test-manifest.xml with a proper manifest file. The manifest found in this repository contains only couple of projects, and was used for testing purposes.

To exectue the setup 'script', simply run:

```
output.sh
```

To test whether the mirror was set up successfully, try initializing a new client using the following command:

```
repo init -u [manifest repo clone url]
```
