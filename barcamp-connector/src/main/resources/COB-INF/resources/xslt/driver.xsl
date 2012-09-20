<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://codebusters.es/formula1/driver"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:xhtml="http://www.w3.org/1999/xhtml">

  <xsl:param name="id"/>

  <xsl:template match="/">
    <driver id="{$id}">
        <xsl:apply-templates select="child::node()"/>
    </driver>
  </xsl:template>

  <xsl:template match="xhtml:div[contains(@class,'driver-generic-data')]//xhtml:h2">
    <name><xsl:value-of select="normalize-space(.)"/></name>
    <image xlink:href="{xhtml:img/@src}"/>
  </xsl:template>

  <xsl:template match="xhtml:table">
    <xsl:call-template name="printCell">
        <xsl:with-param name="cell" select="descendant::xhtml:tr[position()=1]/xhtml:td[position()=1]"/>
        <xsl:with-param name="name" select="'debut'"/>
    </xsl:call-template>
    <xsl:call-template name="printCell">
        <xsl:with-param name="cell" select="descendant::xhtml:tr[position()=2]/xhtml:td[position()=1]"/>
        <xsl:with-param name="name" select="'birthday'"/>
    </xsl:call-template>    
    <xsl:call-template name="printCell">
        <xsl:with-param name="cell" select="descendant::xhtml:tr[position()=3]/xhtml:td[position()=1]"/>
        <xsl:with-param name="name" select="'country'"/>
    </xsl:call-template>
    <xsl:call-template name="printCell">
        <xsl:with-param name="cell" select="descendant::xhtml:tr[position()=4]/xhtml:td[position()=1]"/>
        <xsl:with-param name="name" select="'heigh'"/>
    </xsl:call-template>
    <xsl:call-template name="printCell">
        <xsl:with-param name="cell" select="descendant::xhtml:tr[position()=5]/xhtml:td[position()=1]"/>
        <xsl:with-param name="name" select="'weight'"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="printCell">
    <xsl:param name="cell"/>
    <xsl:param name="name" select="''"/>
    <xsl:if test="normalize-space($name) = ''">
        <xsl:message terminate="yes">
            Unable to create empty element.
        </xsl:message>
    </xsl:if>
    <xsl:element name="{$name}">
        <xsl:value-of select="$cell"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*|text()" priority="-1">
    <xsl:apply-templates select="child::node()"/>
  </xsl:template>
</xsl:stylesheet>