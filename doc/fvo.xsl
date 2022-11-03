<?xml version='1.0'?>	
<xsl:stylesheet  	
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="xsl/html/chunk.xsl"/>
  
  <xsl:param name="html.stylesheet" select="'general.css'"/>
  <xsl:param name="chunk.first.sections" select="1"/>
  <xsl:param name="suppress.navigation" select="1"/>
  <xsl:param name="generate.toc">
book      toc,title
chapter   toc,title
section   toc,title
  </xsl:param>

  <!-- - - - - - - - - - - - - - - - - - - -->
  <!-- definition and list of definitions  -->
  <!-- - - - - - - - - - - - - - - - - - - -->
  <xsl:template match="definition">
    <xsl:call-template name="check.id.unique">
      <xsl:with-param name="id" select="@id"/>
    </xsl:call-template>    
    <xsl:call-template name="anchor"/>
    <span>
      <xsl:attribute name="class">
        <xsl:text>definition</xsl:text>
      </xsl:attribute>
      <em><xsl:apply-templates/></em>
    </span>
  </xsl:template>

  <xsl:template match="definition" mode="xref-to">
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
    <a>
      <xsl:attribute name="href">
	<xsl:call-template name="href.target">
	  <xsl:with-param name="object" select="."/>
	</xsl:call-template>
      </xsl:attribute>
      <xsl:value-of select="$text"/>
    </a>
  </xsl:template>

  <xsl:template match="list-of-definitions">
    <div>
      <xsl:attribute name="class">
        <xsl:text>list-of-definitions</xsl:text>
      </xsl:attribute>
      <span>
	<xsl:attribute name="class">
          <xsl:text>list-of-definitions</xsl:text>
	</xsl:attribute>
	<strong>
	  <xsl:text>Ключевые термины: </xsl:text>
	</strong>

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
	      <a>
		<xsl:attribute name="href">
		  <xsl:call-template name="href.target">
		    <xsl:with-param name="object" select="."/>
		  </xsl:call-template>
		</xsl:attribute>
		<xsl:value-of select="$text"/>
	      </a>
	    </xsl:otherwise>
	  </xsl:choose>
	  <xsl:if test="position() != last()">
	    <xsl:text>, </xsl:text>
	  </xsl:if>
	</xsl:for-each>
      </span>
    </div>
  </xsl:template>
  
  <!-- - - - - - - - - - - - - - - - - - - -->
  <!-- presentation and small-presentaion  -->
  <!-- - - - - - - - - - - - - - - - - - - -->
  <xsl:template match="presentation">
    <div>
      <xsl:attribute name="class">
        <xsl:text>presentation</xsl:text>
      </xsl:attribute>  
      <span>
	<xsl:text>Презентация: слайд&#160; </xsl:text>
	<xsl:value-of select="@number"/>
      </span>
    </div>
  </xsl:template>

  <xsl:template match="small-presentation">
  </xsl:template>

  <!-- - - - - - - - -->
  <!-- question       -->
  <!-- - - - - - - - -->
  <xsl:template match="question" mode="xref-to">
    <a>
      <xsl:attribute name="href">
	<xsl:call-template name="href.target">
	  <xsl:with-param name="object" select="."/>
	</xsl:call-template>
      </xsl:attribute>
      <xsl:value-of select="."/>
    </a>
  </xsl:template>

  <xsl:template match="question">
    <xsl:call-template name="check.id.unique">
      <xsl:with-param name="id" select="@id"/>
    </xsl:call-template>
    <xsl:call-template name="anchor"/>
  </xsl:template>

  <xsl:template match="list-of-questions">
    <div class="{name(.)}">
      <ol class="{name(.)}">
	<xsl:for-each select="../..//question">
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
	      <li><a>
		  <xsl:attribute name="href">
		    <xsl:call-template name="href.target">
		      <xsl:with-param name="object" select="."/>
		    </xsl:call-template>
		  </xsl:attribute>
		  <xsl:value-of select="$text"/>
	      </a></li>
	    </xsl:otherwise>
	  </xsl:choose>	  
	</xsl:for-each>
      </ol>
    </div>
  </xsl:template>

  <xsl:template match="list-of-all-questions">
    <div class="{name(.)}">
      <ol class="{name(.)}">
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
	      <li><a>
		  <xsl:attribute name="href">
		    <xsl:call-template name="href.target">
		      <xsl:with-param name="object" select="."/>
		    </xsl:call-template>
		  </xsl:attribute>
		  <xsl:value-of select="$text"/>
	      </a></li>
	    </xsl:otherwise>
	  </xsl:choose>	  
	</xsl:for-each>
      </ol>
    </div>
  </xsl:template>

  <!-- - - - - - - - -->
  <!-- practice      -->
  <!-- - - - - - - - -->
  <xsl:template match="practice" mode="xref-to">
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="practice">
  </xsl:template>

  <xsl:template match="list-of-practices">
    <div class="{name(.)}">
      <ol class="{name(.)}">
	<xsl:for-each select="../..//practice">
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
	      <li><xsl:value-of select="$text"/></li>
	    </xsl:otherwise>
	  </xsl:choose>	  
	</xsl:for-each>
      </ol>
    </div>
  </xsl:template>

  <xsl:template match="list-of-all-practices">
    <div class="{name(.)}">
      <ol class="{name(.)}">
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
	      <li><xsl:value-of select="$text"/></li>
	    </xsl:otherwise>
	  </xsl:choose>	  
	</xsl:for-each>
      </ol>
    </div>
  </xsl:template>

  <!-- - - - - - - - -->
  <!-- scenario & co -->
  <!-- - - - - - - - -->
  <xsl:template match="scenario">
    <div class="{name(.)}">
      <xsl:call-template name="anchor"/>
      <xsl:if test="title">
	<xsl:apply-templates select="title"/>
      </xsl:if>

      <xsl:apply-templates select="scenario-intro"/>
      <xsl:apply-templates select="scenario-start"/>
      
      <xsl:apply-templates select="*[not(self::title or
				   self::titleabbrev or
				   self::scenario-start or
				   self::scenario-intro)]"/>
    </div>
  </xsl:template>

  <xsl:template match="scenario" mode="xref-to">
    <a>
      <xsl:attribute name="href">
	<xsl:call-template name="href.target">
	  <xsl:with-param name="object" select="."/>
	</xsl:call-template>
      </xsl:attribute>
      <xsl:value-of select="title"/>
    </a>
  </xsl:template>

  <xsl:template match="scenario/title">
    <p><b>
	<xsl:text>Сценарий: </xsl:text>
	<xsl:apply-templates/>
    </b></p>
  </xsl:template>

  <xsl:template match="scenario-intro">
    <p><xsl:apply-templates/></p>
  </xsl:template>

  <xsl:template match="scenario-start">
    <p>
      <em>
	<xsl:text>Начальные условия:</xsl:text>
      </em>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  
  <xsl:template match="scenario-summary">
    <xsl:variable name="targets" select="key('id',@scenario-id)"/>
    <xsl:variable name="target" select="$targets[1]"/>
    <div class="{name(.)}">
      <xsl:apply-templates select="$target/title"/>
      <ol class="{name(.)}">
	<xsl:for-each select="$target//command">
 	  <li>
	    <xsl:value-of select="."/>
	  </li>
	</xsl:for-each>
      </ol>
    </div>
  </xsl:template>
  
  <xsl:template match="list-of-scenarios">
    <div class="{name(.)}">
      <p><b><xsl:text>Список сценариев:</xsl:text></b></p>
      <ol>
	<xsl:for-each select="/book/chapter/sect1//scenario">
	  <li><a>
	    <xsl:attribute name="href">
	      <xsl:call-template name="href.target">
		<xsl:with-param name="object" select="."/>
	      </xsl:call-template>
	    </xsl:attribute>
	    <xsl:value-of select="title"/>
	  </a></li>
	</xsl:for-each>
      </ol>
    </div>
  </xsl:template>    

  <xsl:template match="blink-sect2">
  </xsl:template>

</xsl:stylesheet> 		 
