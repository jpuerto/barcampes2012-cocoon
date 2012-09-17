<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://codebusters.es/formula1/driver"
  xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:i="http://apache.org/cocoon/3.0/include">


  <xsl:template match="/">
    <teams>
        <xsl:apply-templates select="//xhtml:li" />
    </teams>
  </xsl:template>

  <xsl:template match="xhtml:li">
    <xsl:for-each select="descendant::xhtml:span/xhtml:a">
        <i:include src="{concat('servlet:/drivers/', substring-before(substring-after(./@href, '/formula1/'), '.html'),'.xml')}"/>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>