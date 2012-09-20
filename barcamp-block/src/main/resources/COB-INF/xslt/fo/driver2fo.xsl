<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://codebusters.es/formula1/driver"
  xmlns:d="http://codebusters.es/formula1/driver" xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <xsl:template match="/">
    <fo:root>
      <fo:layout-master-set>
        <fo:simple-page-master master-name="A4-portrait"
          page-height="29.7cm" page-width="21.0cm" margin="2cm">
          <fo:region-body />
        </fo:simple-page-master>
      </fo:layout-master-set>
      <fo:page-sequence master-reference="A4-portrait">
        <fo:flow flow-name="xsl-region-body">
          <xsl:apply-templates select="//d:driver" />
        </fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>

  <xsl:template name="image">
    <xsl:param name="src" select="''" />
    <fo:block font-size="14pt">
      <fo:external-graphic width="100pt" height="100pt"
        content-width="50pt" content-height="50pt" text-align="start"
        display-align="after" src="{$src}" />
    </fo:block>
  </xsl:template>

  <xsl:template name="paragraph">
    <xsl:param name="text" select="''" />
    <fo:block font-size="14pt">
      <xsl:value-of select="$text" />
    </fo:block>
  </xsl:template>

  <xsl:template match="d:driver">
    <xsl:call-template name="image">
      <xsl:with-param name="src" select="d:image/@xlink:href" />
    </xsl:call-template>
    <xsl:call-template name="paragraph">
      <xsl:with-param name="text">
        Name:
        <xsl:value-of select="d:name" />
      </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="paragraph">
      <xsl:with-param name="text">
        Debut:
        <xsl:value-of select="d:debut" />
      </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="paragraph">
      <xsl:with-param name="text">
        Birthday:
        <xsl:value-of select="d:birthday" />
      </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="paragraph">
      <xsl:with-param name="text">
        Country:
        <xsl:value-of select="d:country" />
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

</xsl:stylesheet>