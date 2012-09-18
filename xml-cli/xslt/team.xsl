<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://codebusters.es/formula1/team"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:xhtml="http://www.w3.org/1999/xhtml">

  <xsl:output indent="yes"/>

  <xsl:param name="id"/>

  <xsl:include href="helper.xsl"/>

  <xsl:template match="/">
    <team id="{$id}">
        <xsl:apply-templates select="child::node()"/>
    </team>
  </xsl:template>

  <xsl:template match="xhtml:div[contains(@class,'team-generic-data')]//xhtml:h2">
    <name><xsl:value-of select="normalize-space(.)"/></name>
    <image xlink:href="{xhtml:img/@src}"/>
  </xsl:template>

  <xsl:template match="xhtml:table[@class='team-profile']">
    <xsl:call-template name="printCell">
        <xsl:with-param name="cell" select="descendant::xhtml:tr[position()=1]/xhtml:td[position()=1]"/>
        <xsl:with-param name="name" select="'cups'"/>
    </xsl:call-template>
    <xsl:call-template name="printCell">
        <xsl:with-param name="cell" select="descendant::xhtml:tr[position()=1]/xhtml:td[position()=2]"/>
        <xsl:with-param name="name" select="'founded'"/>
    </xsl:call-template>    
    <xsl:call-template name="printCell">
        <xsl:with-param name="cell" select="descendant::xhtml:tr[position()=2]/xhtml:td[position()=1]"/>
        <xsl:with-param name="name" select="'points'"/>
    </xsl:call-template>
    <xsl:call-template name="printCell">
        <xsl:with-param name="cell" select="descendant::xhtml:tr[position()=2]/xhtml:td[position()=2]"/>
        <xsl:with-param name="name" select="'founder'"/>
    </xsl:call-template>
    <xsl:call-template name="printCell">
        <xsl:with-param name="cell" select="descendant::xhtml:tr[position()=3]/xhtml:td[position()=1]"/>
        <xsl:with-param name="name" select="'wins'"/>
    </xsl:call-template>
    <xsl:call-template name="printCell">
        <xsl:with-param name="cell" select="descendant::xhtml:tr[position()=4]/xhtml:td[position()=1]"/>
        <xsl:with-param name="name" select="'homepage'"/>
    </xsl:call-template>
  </xsl:template>

</xsl:stylesheet>
