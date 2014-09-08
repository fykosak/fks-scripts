<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!--
	Params:
		series: 1..6
	-->
    <xsl:param name="series"/>
	<xsl:output method="text" indent="no"/>
	<xsl:strip-space elements="*"/>
	<xsl:decimal-format name="european" decimal-separator=',' grouping-separator='.' />

	<xsl:template match="/">
		<!-- this allows nesting stats element arbitrarily -->
		<xsl:apply-templates select="//stats"></xsl:apply-templates>
	</xsl:template>
	
	<xsl:template match="stats">
		<xsl:apply-templates select="task[@series=$series]"></xsl:apply-templates>
	</xsl:template>

	<xsl:template match="task">
		<xsl:if test="not(@tasknr)">
			<xsl:message terminate="yes">
				Error: You are using incompatible XML with statistics, it doesn't contain 'tasknr' attribute.
				Please refresh your statistics files by calling appropriate web service request.
			</xsl:message>
		</xsl:if>
		<xsl:value-of select="$series"/>
		<xsl:text>;</xsl:text>
		<xsl:value-of select="@tasknr"/>	
		<xsl:text>;</xsl:text>
		<xsl:value-of select="points"/>	
		<xsl:text>;</xsl:text>
		<xsl:value-of select="format-number(average, '#0,00', 'european')"/>	
		<xsl:text>;</xsl:text>
		<xsl:value-of select="solvers"/>
		<xsl:text>
</xsl:text>
	</xsl:template>
</xsl:stylesheet>

