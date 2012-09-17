<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:t="http://codebusters.es/formula1/team">

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

  <xsl:variable name="numItems" select="count(//t:team)"/>
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
        <xsl:apply-templates select="//t:team">
            <xsl:sort select="t:*[local-name() = $sidx]" order="{$sort}" data-type="number"/>
        </xsl:apply-templates>
    </rows>
  </xsl:template>

  <xsl:template match="t:team[position() &gt; $startRange and position() &lt;= $endRange]">
    <row id="{@id}">
        <cell><xsl:value-of select="@id"/></cell>
        <cell><xsl:value-of select="t:name"/></cell>
        <cell><xsl:value-of select="t:image/@xlink:href"/></cell>
        <cell><xsl:value-of select="t:cups"/></cell>
        <cell><xsl:value-of select="t:points"/></cell>
        <cell><xsl:value-of select="t:homepage"/></cell>
    </row>
  </xsl:template>

</xsl:stylesheet>