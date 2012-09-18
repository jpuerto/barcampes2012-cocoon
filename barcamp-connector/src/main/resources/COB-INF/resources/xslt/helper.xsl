<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template name="printCell">
    <xsl:param name="cell"/>
    <xsl:param name="name" select="''"/>
    <xsl:if test="normalize-space($name) = ''">
        <xsl:message terminate="yes">
            Unable to create empty element.
        </xsl:message>
    </xsl:if>
    <xsl:element name="{$name}">
        <xsl:value-of select="normalize-space($cell)"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*|text()" priority="-1">
    <xsl:apply-templates select="child::node()"/>
  </xsl:template>
</xsl:stylesheet>