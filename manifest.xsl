<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" omit-xml-declaration="yes" indent="no"/>
<xsl:template match="/">

<!-- Create the Deveo project -->

curl -X POST \
  -H "Accept: application/vnd.deveo.v1" \
  -H "Authorization: deveo plugin_key='<xsl:value-of select="$PLUGIN_KEY" />',company_key='<xsl:value-of select="$COMPANY_KEY" />',account_key='<xsl:value-of select="$ACCOUNT_KEY" />'" \
  -H "Content-Type: application/json" \
  -d '{ "id": "<xsl:value-of select="$DEVEO_PROJECT" />", "name": "<xsl:value-of select="$DEVEO_PROJECT" />" }' \
  https://<xsl:value-of select="$DEVEO_URL" />/api/projects

<!-- Create repos to Deveo -->

curl -X POST \
  -H "Accept: application/vnd.deveo.v1" \
  -H "Authorization: deveo plugin_key='<xsl:value-of select="$PLUGIN_KEY" />',company_key='<xsl:value-of select="$COMPANY_KEY" />',account_key='<xsl:value-of select="$ACCOUNT_KEY" />'" \
  -H "Content-Type: application/json" \
  -d '{ "id": "platform/manifest", "type": "git" }' \
  https://<xsl:value-of select="$DEVEO_URL" />/api/projects/<xsl:value-of select="$DEVEO_PROJECT" />/repositories

      <xsl:for-each select="manifest/project">
curl -X POST \
  -H "Accept: application/vnd.deveo.v1" \
  -H "Authorization: deveo plugin_key='<xsl:value-of select="$PLUGIN_KEY" />',company_key='<xsl:value-of select="$COMPANY_KEY" />',account_key='<xsl:value-of select="$ACCOUNT_KEY" />'" \
  -H "Content-Type: application/json" \
  -d '{ "id": "<xsl:value-of select="@name"/>", "type": "git" }' \
  https://<xsl:value-of select="$DEVEO_URL" />/api/projects/<xsl:value-of select="$DEVEO_PROJECT" />/repositories
      </xsl:for-each>
<!-- End of Creating repos to Deveo -->

<!-- Clone repos -->
git clone --bare https://<xsl:value-of select="$ANDROID_URL" />/platform/manifest platform/manifest
      <xsl:for-each select="manifest/project">
git clone --bare https://<xsl:value-of select="$ANDROID_URL" />/<xsl:value-of select="@name"/><xsl:text> </xsl:text><xsl:value-of select="@path"/></xsl:for-each>
<!-- End of cloning repos -->



<!-- Push the repos -->
cd platform/manifest
git remote add deveo https://<xsl:value-of select="$DEVEO_USERNAME"/>@<xsl:value-of select="$DEVEO_URL"/>/<xsl:value-of select="$DEVEO_COMPANY"/>/projects/<xsl:value-of select="$DEVEO_PROJECT"/>/repositories/git/platform/manifest
git push --mirror deveo
cd - 
      <xsl:for-each select="manifest/project">
cd <xsl:value-of select="@path"/>
git remote add deveo https://<xsl:value-of select="$DEVEO_USERNAME"/>@<xsl:value-of select="$DEVEO_URL"/>/<xsl:value-of select="$DEVEO_COMPANY"/>/projects/<xsl:value-of select="$DEVEO_PROJECT"/>/repositories/git/<xsl:value-of select="@name"/>
git push --mirror deveo
cd -
</xsl:for-each>
<!-- End of pushing repos -->


</xsl:template>
</xsl:stylesheet>


