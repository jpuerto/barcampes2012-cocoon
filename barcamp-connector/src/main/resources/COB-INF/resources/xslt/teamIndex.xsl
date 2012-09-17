<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml"
  xmlns:xhtml="http://www.w3.org/1999/xhtml">


  <xsl:template match="/">
    <html>
      <head>
      </head>
      <body>
        <ul>
          <xsl:apply-templates select="//xhtml:li" />
        </ul>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="xhtml:li">
    <li>
      <a href="{substring-after(xhtml:h3/xhtml:a/@href, '/formula1/')}">
        <xsl:value-of select="xhtml:h3/xhtml:a" />
      </a>
      <br/>
      <xsl:for-each select="descendant::xhtml:span/xhtml:a">
        <a href="{substring-after(./@href, '/formula1/')}">
            <xsl:value-of select="." />
        </a>
      </xsl:for-each>
    </li>
  </xsl:template>
</xsl:stylesheet>