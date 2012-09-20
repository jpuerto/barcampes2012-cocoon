<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:d="http://codebusters.es/formula1/driver">

  <xsl:param name="num" select="number(10)"/>
  <xsl:param name="page" select="number(1)"/>
  <xsl:param name="sidx" select="'name'"/>
  <xsl:param name="sord" select="'asc'"/>
  
  <xsl:variable name="sort">
    <xsl:choose>
        <xsl:when test="$sord = 'desc'">descending</xsl:when>
        <xsl:otherwise>ascending</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="numItems" select="count(//d:driver)"/>
  <xsl:variable name="numPages" select="ceiling($numItems div $num)"/>

  <xsl:variable name="startRange" select="$num * ($page - 1)"/>
  <xsl:variable name="endRange" select="$startRange + $num"/>

  <xsl:template match="/">
    <rows>
        <page><xsl:value-of select="$page"/></page>
        <total><xsl:value-of select="$numPages"/></total>
        <records><xsl:value-of select="$numItems"/></records>
        <start><xsl:value-of select="$startRange"/></start>
        <end><xsl:value-of select="$endRange"/></end>
        <xsl:apply-templates select="//d:driver">
            <xsl:sort select="d:*[local-name() = $sidx]" order="{$sort}" data-type="text"/>
        </xsl:apply-templates>
    </rows>
  </xsl:template>

  <xsl:template match="d:driver">
    <xsl:if test="position() &gt; $startRange and position() &lt;= $endRange">
      <row id="{@id}">
          <cell><xsl:value-of select="d:name"/></cell>
          <cell><xsl:value-of select="d:image/@xlink:href"/></cell>
          <cell><xsl:value-of select="d:debut"/></cell>
          <cell><xsl:value-of select="d:birthday"/></cell>
          <cell><xsl:value-of select="d:country"/></cell>
      </row>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>