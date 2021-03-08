<?xml version="1.0" encoding="utf-8"?>
<stylesheet xmlns="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<output method="text" indent="no"/>
	<strip-space elements="*"/>

	<template match="signatures">
		<!-- this allows nesting stats element arbitrarily -->
        <apply-templates select="org"></apply-templates>
	</template>
	
	<template match="org">
		<!-- team header -->
		<text>\newsignature{</text>
		<value-of select="name"/>
		<text>}{</text>
		<value-of select="texSignature"/>
		<text>}{</text>
		<value-of select="domainAlias"/>
		<text>}</text>
		<text>
</text>
	</template>

	<template name="tex">
		
	</template>
</stylesheet>

