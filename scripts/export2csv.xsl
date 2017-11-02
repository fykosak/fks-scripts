<?xml version="1.0" encoding="utf-8"?>
<stylesheet xmlns="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<output method="text" indent="no"/>
	<strip-space elements="*"/>

	<template match="/">
		<!-- this allows nesting stats element arbitrarily -->
		<apply-templates select="//export"/>
	</template>
	
	<template match="export">
		<apply-templates select="column-definitions/column-definition"/>
		<text>
</text>
		<apply-templates select="data/row"/>
	</template>

	<template match="row">
		<apply-templates select="col"/>
		<text>
</text>
	</template>

	<template match="col">
		<if test="position()!=1"><text>;</text></if>
		<value-of select="text()"/>
	</template>

	<template match="column-definition">
		<if test="position()!=1"><text>;</text></if>
		<value-of select="@name"/>
	</template>
</stylesheet>

