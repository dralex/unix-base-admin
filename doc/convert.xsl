<?xml version='1.0' encoding="UTF-8"?>	
<xsl:stylesheet  	
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output encoding="UTF-8"/>
  
  <xsl:template match="definition">
    <xsl:variable name="text">
      <xsl:choose>
	<xsl:when test="boolean(@orig)">
	  <xsl:value-of select="@orig"/>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:value-of select="."/>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <emphasis>
      <xsl:attribute name="id">
	<xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:attribute name="xreflabel">
	<xsl:value-of select="$text"/>
      </xsl:attribute>
      <xsl:value-of select="."/>
    </emphasis>
  </xsl:template>
  
  <xsl:template match="list-of-definitions">
    <para>
      <emphasis>
	<xsl:text>Ключевые термины: </xsl:text>
      </emphasis>      
      <xsl:for-each select="../..//definition">
	<xsl:variable name="text">
	  <xsl:choose>
	    <xsl:when test="boolean(@orig)">
	      <xsl:value-of select="@orig"/>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:value-of select="."/>
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:variable>
	
	<xsl:choose>
	  <xsl:when test="not(boolean(@id))">
	    <xsl:message>
	      <xsl:text>Definition without id: </xsl:text>
	      <xsl:value-of select="$text"/>
	    </xsl:message>
	    <xsl:value-of select="$text"/>
	  </xsl:when>
	  <xsl:otherwise>
	    <xref>
	      <xsl:attribute name="linkend">
		<xsl:value-of select="@id"/>
	      </xsl:attribute>
	    </xref>
	  </xsl:otherwise>
	</xsl:choose>
	<xsl:if test="position() != last()">
	  <xsl:text>, </xsl:text>
	</xsl:if>
      </xsl:for-each>
    </para>
  </xsl:template>

  <xsl:template match="presentation">
    <para>
      <link>
	<xsl:attribute name="linkend">
	  <xsl:text>small-pres-</xsl:text>
	  <xsl:value-of select="@number"/>
	</xsl:attribute>
	
	<xsl:text>Презентация </xsl:text>
	<xsl:value-of select="@number"/>
	<xsl:text>: </xsl:text>
	<xsl:value-of select="@name"/>
      </link>
    </para>
  </xsl:template>

  <xsl:template match="list-of-scenarios">
  </xsl:template>

  <xsl:template match="question">
    <xsl:variable name="text">
      <xsl:value-of select="."/>
    </xsl:variable>
    <phrase>
      <xsl:attribute name="id">
	<xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:attribute name="xreflabel">
	<xsl:value-of select="$text"/>
      </xsl:attribute>
    </phrase>
  </xsl:template>

  <xsl:template match="list-of-questions">
    <sect2>
      <xsl:attribute name="id">
	<xsl:value-of select="@id"/>
      </xsl:attribute>
      <title>Вопросы</title>
      <para>
	<orderedlist>
	  <xsl:for-each select="..//question">
	    <xsl:variable name="text">
	      <xsl:value-of select="."/>
	    </xsl:variable>	  
	    <xsl:choose>
	      <xsl:when test="not(boolean(@id))">
		<xsl:message>
		  <xsl:text>Question without id: </xsl:text>
		  <xsl:value-of select="$text"/>
		</xsl:message>
		<xsl:value-of select="$text"/>
	      </xsl:when>
	      <xsl:otherwise>
		<listitem>
		  <xref>
		    <xsl:attribute name="linkend">
		      <xsl:value-of select="@id"/>
		    </xsl:attribute>		  
		  </xref>
		</listitem>
	      </xsl:otherwise>
	    </xsl:choose>	  
	  </xsl:for-each>
	</orderedlist>
      </para>
    </sect2>
  </xsl:template>

  <xsl:template match="list-of-all-questions">
    <para>
      <orderedlist>
	<xsl:for-each select="/book//question">
	  <xsl:variable name="text">
	    <xsl:value-of select="."/>
	  </xsl:variable>	  
	  <xsl:choose>
	    <xsl:when test="not(boolean(@id))">
	      <xsl:message>
		<xsl:text>Question without id: </xsl:text>
		<xsl:value-of select="$text"/>
	      </xsl:message>
	      <xsl:value-of select="$text"/>
	    </xsl:when>
	    <xsl:otherwise>
	      <listitem>
		<xref>
		  <xsl:attribute name="linkend">
		    <xsl:value-of select="@id"/>
		  </xsl:attribute>		  
		</xref>
	      </listitem>
	    </xsl:otherwise>
	  </xsl:choose>	  
	</xsl:for-each>
      </orderedlist>
    </para>
  </xsl:template>

  <xsl:template match="small-presentation">
    <sect2>
      <xsl:attribute name="id">
	<xsl:value-of select="@id"/>
      </xsl:attribute>
      <title>Презентация</title>
      <xsl:for-each select="..//presentation">
	<para>
	  <figure>
	    <xsl:attribute name="id">
	      <xsl:text>small-pres-</xsl:text>
	      <xsl:value-of select="@number"/>
	    </xsl:attribute>
	    <title>
	      <xsl:text>Презентация </xsl:text>
	      <xsl:value-of select="@number"/>
	      <xsl:text>: </xsl:text>
	      <xsl:value-of select="@name"/>
	    </title>
	    <graphic>
	      <xsl:attribute name="fileref">
	      	<xsl:text>pres/small-lect</xsl:text>
		<xsl:value-of select="@number"/>
		<xsl:text>.png</xsl:text>
	      </xsl:attribute>
	    </graphic>
	  </figure>
	</para> 
      </xsl:for-each>
    </sect2>
  </xsl:template>

  <xsl:template match="practice">
  </xsl:template>

  <xsl:template match="list-of-practices">
    <sect2>
      <xsl:attribute name="id">
	<xsl:value-of select="@id"/>
      </xsl:attribute>
      <title>Задания для самоподготовки</title>
      <orderedlist>
	<xsl:for-each select="..//practice">
	  <xsl:variable name="text">
	    <xsl:value-of select="."/>
	  </xsl:variable>
	  <xsl:choose>
	    <xsl:when test="not(boolean(@id))">
	      <xsl:message>
		<xsl:text>Practice without id: </xsl:text>
		<xsl:value-of select="$text"/>
	      </xsl:message>
	      <xsl:value-of select="$text"/>
	    </xsl:when>
	    <xsl:otherwise>
	      <listitem><xsl:value-of select="$text"/></listitem>
	    </xsl:otherwise>
	  </xsl:choose>	  
	</xsl:for-each>
      </orderedlist>
    </sect2>
  </xsl:template>

  <xsl:template match="list-of-all-practices">
    <orderedlist>
      <xsl:for-each select="/book//practice">
	<xsl:variable name="text">
	  <xsl:value-of select="."/>
	</xsl:variable>
	<xsl:choose>
	  <xsl:when test="not(boolean(@id))">
	    <xsl:message>
	      <xsl:text>Practice without id: </xsl:text>
	      <xsl:value-of select="$text"/>
	    </xsl:message>
	    <xsl:value-of select="$text"/>
	  </xsl:when>
	  <xsl:otherwise>
	    <listitem><xsl:value-of select="$text"/></listitem>
	  </xsl:otherwise>
	</xsl:choose>	  
      </xsl:for-each>
    </orderedlist>
  </xsl:template>
  
  <xsl:template match="scenario">
    <sect2 id="{@id}">
      <title>
	<xsl:text>Сценарий: </xsl:text>
	<xsl:value-of select="title"/>
      </title>
      <para>
	<xsl:value-of select="scenario-intro"/>
      </para>
      <para>
	<emphasis>
	  <xsl:text>Начальные условия:</xsl:text>
	</emphasis>
	<xsl:value-of select="scenario-start"/>
      </para>

      <xsl:apply-templates select="*[not(self::title or
				   self::titleabbrev or
				   self::scenario-start or
				   self::scenario-intro)]"/>
    </sect2>
  </xsl:template>
  
  <xsl:template match="sect1-scenario">
    <sect1 id="{@id}">
      <title>
	<xsl:text>Практическое занятие. </xsl:text>
	<xsl:value-of select="title"/>
      </title>      
      <xsl:apply-templates select="*[not(self::title or self::titleabbrev)]"/>
    </sect1>
    <sect1 id="{@id}-scenarios">
      <title>
	<xsl:text>Сценарии практического занятия на тему: </xsl:text>	
	<xsl:value-of select="title"/>
      </title>
      <xsl:for-each select=".//scenario">
	<xsl:if test="not(@dontlog)">
	  <para>
	    <xref linkend="{@id}"/>
	    <orderedlist>
	      <xsl:for-each select=".//command">
		<xsl:if test="not(@dontlog)">
 	          <listitem>
		    <xsl:value-of select="."/>
	          </listitem>
		</xsl:if>
	      </xsl:for-each>
	    </orderedlist>
	  </para>
	</xsl:if>
      </xsl:for-each>
    </sect1>
  </xsl:template>
  
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
  
</xsl:stylesheet> 		
