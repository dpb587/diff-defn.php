<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:php="http://php.net/xsl">
    <xsl:template match="/">
        <html>
            <head>
                <style type="text/css">
                    a {
                        color: #3333CC;
                    }

                    body, code, ol, pre {
                        margin: 0;
                    }

                    body {
                        font-family: 'helvetica neue', helvetica, arial, sans-serif;
                        font-size: 13px;
                        line-height: 18px;
                    }

                    code, pre {
                        border-radius: 3px;
                        font-family: menlo, monaco, consolas, 'courier new', monospace;
                        font-size: 12px;
                    }

                    code {
                        background-color: #F7F7F9;
                        border: #D8D8D8 solid 1px;
                        padding: 2px 4px;
                    }

                    dl {
                        margin: 4px;
                    }

                    dl dd, dl dt {
                        margin-bottom: 4px;
                    }

                    dl dd {
                        margin-left: 16px;
                    }

                    dl dd dl {
                        margin-bottom: 8px;
                    }

                    dl dt {
                        border-top: #EEEEEE solid 1px;
                        padding: 4px 4px 0;
                    }

                    footer {
                        border-top: #E0E0E0 solid 1px;
                        padding: 16px 12px;
                    }

                    h1, h2, h3, h4, h5, h6 {
                        margin: 0;
                    }

                    h1 small, h2 small, h3 small, h4 small, h5 small, h6 small {
                        color: #797979;
                        font-size: 13px;
                        font-weight: normal;
                    }

                    h1 {
                        font-size: 24px;
                    }

                    h2 {
                        font-size: 18px;
                    }

                    h3 {
                        color: #333333;
                        font-size: 14px;
                    }

                    header {
                        border-bottom: #C9C9C9 solid 1px;
                        padding: 16px 12px;
                    }

                    i.bullet-added, i.bullet-touched, i.bullet-removed {
                        -webkit-border-top-left-radius: 8px;
                        -webkit-border-bottom-right-radius: 8px;
                        -moz-border-radius-topleft: 8px;
                        -moz-border-radius-bottomright: 8px;
                        border-top-left-radius: 8px;
                        border-bottom-right-radius: 8px;
                        display: inline-block;
                        margin-right: 6px;
                        width: 6px;
                    }

                    i.bullet-added {
                        background-color: #339933;
                    }

                    i.bullet-touched {
                        background-color: #CCAA55;
                    }

                    i.bullet-removed {
                        background-color: #993333;
                    }

                    ol, ul {
                        margin: 10px 0 0;
                    }

                    p {
                        margin: 10px 0 0;
                    }

                    section {
                        border-bottom: #DCDCDC solid 1px;
                        border-top: #F3F3F3 solid 1px;
                        padding: 16px 12px;
                    }

                    small {
                        color: #999999;
                    }
                </style>
            </head>

            <body>
                <header>
                    <h1><xsl:value-of select="/root/defn[@id = 'source']/@repository" /></h1>

                    <p>
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="/root/defn[@id = 'source']/@repository-link" />
                            </xsl:attribute>
                            <xsl:value-of select="/root/defn[@id = 'source']/@repository-link" />
                        </a>
                        &#8213;
                        comparing
                        <code>
                            <a>
                                <xsl:attribute name="href">
                                    <xsl:value-of select="php:function('str_replace', '%commit%', string(/root/defn[@id = 'source']/defn[@id = 'commit']/@value), string(/root/defn[@id = 'source']/@commit-link))" />
                                </xsl:attribute>
                                <xsl:value-of select="substring(/root/defn[@id = 'source']/defn[@id = 'commit']/@value, 0, 8)" />
                            </a>
                        </code>
                        &#8230;
                        <code>
                            <a>
                                <xsl:attribute name="href">
                                    <xsl:value-of select="php:function('str_replace', '%commit%', string(/root/defn[@id = 'source']/defn[@id = 'commit']/diff-old/defn[@id = 'commit']/@value), string(/root/defn[@id = 'source']/@commit-link))" />
                                </xsl:attribute>
                                <xsl:value-of select="substring(/root/defn[@id = 'source']/defn[@id = 'commit']/diff-old/defn[@id = 'commit']/@value, 0, 8)" />
                            </a>
                        </code>
                    </p>
                </header>

                <xsl:variable name="constant_add" select="count(/root/constant[@diff = 'added'])" />
                <xsl:variable name="constant_removed" select="count(/root/constant[@diff = 'removed'])" />
                <xsl:variable name="constant_touched" select="count(/root/constant[@diff = 'touched'])" />
            
                <xsl:if test="$constant_add or $constant_touched or $constant_removed">
                    <section>
                        <h2>
                            Constants
                            <small>
                                &#8212;
                                <xsl:if test="$constant_add">
                                    <xsl:value-of select="$constant_add" />
                                    added<xsl:if test="$constant_removed or $constant_touched">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$constant_removed">
                                    <xsl:value-of select="$constant_removed" />
                                    removed<xsl:if test="$constant_touched">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$constant_touched">
                                    <xsl:value-of select="$constant_touched" />
                                    touched
                                </xsl:if>
                            </small>
                        </h2>

                        <dl>
                            <xsl:apply-templates select="/root/constant[@diff = 'added']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="/root/constant[@diff = 'removed']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="/root/constant[@diff = 'touched']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                        </dl>
                    </section>
                </xsl:if>

                <xsl:variable name="interface_add" select="count(/root/interface[@diff = 'added'])" />
                <xsl:variable name="interface_removed" select="count(/root/interface[@diff = 'removed'])" />
                <xsl:variable name="interface_touched" select="count(/root/interface[@diff = 'touched'])" />
            
                <xsl:if test="$interface_add or $interface_touched or $interface_removed">
                    <section>
                        <h2>
                            Interfaces
                            <small>
                                &#8212;
                                <xsl:if test="$interface_add">
                                    <xsl:value-of select="$interface_add" />
                                    added<xsl:if test="$interface_removed or $interface_touched">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$interface_removed">
                                    <xsl:value-of select="$interface_removed" />
                                    removed<xsl:if test="$interface_touched">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$interface_touched">
                                    <xsl:value-of select="$interface_touched" />
                                    touched
                                </xsl:if>
                            </small>
                        </h2>

                        <dl>
                            <xsl:apply-templates select="/root/interface[@diff = 'added']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="/root/interface[@diff = 'removed']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="/root/interface[@diff = 'touched']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                        </dl>
                    </section>
                </xsl:if>

                <xsl:variable name="class_add" select="count(/root/class[@diff = 'added'])" />
                <xsl:variable name="class_removed" select="count(/root/class[@diff = 'removed'])" />
                <xsl:variable name="class_touched" select="count(/root/class[@diff = 'touched'])" />

                <xsl:if test="$class_add or $class_touched or $class_removed">
                    <section>
                        <h2>
                            Classes
                            <small>
                                &#8212;
                                <xsl:if test="$class_add">
                                    <xsl:value-of select="$class_add" />
                                    added<xsl:if test="$class_removed or $class_touched">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$class_removed">
                                    <xsl:value-of select="$class_removed" />
                                    removed<xsl:if test="$class_touched">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$class_touched">
                                    <xsl:value-of select="$class_touched" />
                                    touched
                                </xsl:if>
                            </small>
                        </h2>

                        <dl>
                            <xsl:apply-templates select="/root/class[@diff = 'added']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="/root/class[@diff = 'removed']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="/root/class[@diff = 'touched']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                        </dl>
                    </section>
                </xsl:if>

                <xsl:variable name="function_add" select="count(/root/function[@diff = 'added'])" />
                <xsl:variable name="function_removed" select="count(/root/function[@diff = 'removed'])" />
                <xsl:variable name="function_touched" select="count(/root/function[@diff = 'touched'])" />
                
                <xsl:if test="$function_add or $function_touched or $function_removed">
                    <section>
                        <h2>
                            Functions
                            <small>
                                &#8212;
                                <xsl:if test="$function_add">
                                    <xsl:value-of select="$function_add" />
                                    added<xsl:if test="$function_removed or $function_touched">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$function_removed">
                                    <xsl:value-of select="$function_removed" />
                                    removed<xsl:if test="$function_touched">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$function_touched">
                                    <xsl:value-of select="$function_touched" />
                                    touched
                                </xsl:if>
                            </small>
                        </h2>

                        <dl>
                            <xsl:apply-templates select="/root/function[@diff = 'added']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="/root/function[@diff = 'removed']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="/root/function[@diff = 'touched']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                        </dl>
                    </section>
                </xsl:if>

                <footer>
                    <p style="margin-top:0;">
                        <a href="http://dpb587.github.com/">dpb587</a>/<a href="http://dpb587.github.com/def-diff/">def-diff</a>
                        &#8212;
                        a tool for comparing application definitions.
                    </p>
                </footer>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="//constant[@diff = 'added']">
        <dt>
            <i class="bullet-added">&#160;</i>
            <code>
                <a>
                    <xsl:attribute name="href">
                        <xsl:value-of select="php:function('str_replace', '%line%', string(defn-source[@id = 'source']/@line), php:function('str_replace', '%file%', string(defn-source[@id = 'source']/@file), php:function('str_replace', '%commit%', string(/root/defn[@id = 'source']/defn[@id = 'commit']/@value), string(/root/defn[@id = 'source']/@file-link))))" />
                    </xsl:attribute>
                    <xsl:value-of select="@id" />
                </a>
            </code>
        </dt>
    </xsl:template>

    <xsl:template match="//constant[@diff = 'removed']">
        <dt>
            <i class="bullet-removed">&#160;</i>
            <code>
                <a>
                    <xsl:attribute name="href">
                        <xsl:value-of select="php:function('str_replace', '%line%', string(defn-source[@id = 'source']/@line), php:function('str_replace', '%file%', string(defn-source[@id = 'source']/@file), php:function('str_replace', '%commit%', string(/root/defn[@id = 'source']/defn[@id = 'commit']/diff-old/defn[@id = 'commit']/@value), string(/root/defn[@id = 'source']/@file-link))))" />
                    </xsl:attribute>
                    <xsl:value-of select="@id" />
                </a>
            </code>
        </dt>
    </xsl:template>

    <xsl:template match="//class[@diff = 'added']">
        <dt>
            <i class="bullet-added">&#160;</i>
            <code>
                <a>
                    <xsl:attribute name="href">
                        <xsl:value-of select="php:function('str_replace', '%line%', string(defn-source[@id = 'source']/@line), php:function('str_replace', '%file%', string(defn-source[@id = 'source']/@file), php:function('str_replace', '%commit%', string(/root/defn[@id = 'source']/defn[@id = 'commit']/@value), string(/root/defn[@id = 'source']/@file-link))))" />
                    </xsl:attribute>
                    <xsl:value-of select="@id" />
                </a>
            </code>

            <xsl:variable name="constants" select="count(constant)" />
            <xsl:variable name="functions" select="count(function)" />

            <xsl:if test="$constants or $functions">
                <small>
                    &#8211;
                    <xsl:if test="$constants">
                        <xsl:value-of select="$constants" /> constant<xsl:if test="$constants &gt; 1">s</xsl:if><xsl:if test="$functions">, </xsl:if>
                    </xsl:if>
                    <xsl:if test="$functions">
                        <xsl:value-of select="$functions" /> function<xsl:if test="$functions &gt; 1">s</xsl:if>
                    </xsl:if>
                </small>
            </xsl:if>
        </dt>
    </xsl:template>

    <xsl:template match="//class[@diff = 'removed']">
        <dt>
            <i class="bullet-removed">&#160;</i>
            <code>
                <a>
                    <xsl:attribute name="href">
                        <xsl:value-of select="php:function('str_replace', '%line%', string(defn-source[@id = 'source']/@line), php:function('str_replace', '%file%', string(defn-source[@id = 'source']/@file), php:function('str_replace', '%commit%', string(/root/defn[@id = 'source']/defn[@id = 'commit']/diff-old/defn[@id = 'commit']/@value), string(/root/defn[@id = 'source']/@file-link))))" />
                    </xsl:attribute>
                    <xsl:value-of select="@id" />
                </a>
            </code>

            <xsl:variable name="constants" select="count(constant)" />
            <xsl:variable name="functions" select="count(function)" />

            <xsl:if test="$constants or $functions">
                <small>
                    &#8211;
                    <xsl:if test="$constants">
                        <xsl:value-of select="$constants" /> constant<xsl:if test="$constants &gt; 1">s</xsl:if><xsl:if test="$functions">, </xsl:if>
                    </xsl:if>
                    <xsl:if test="$functions">
                        <xsl:value-of select="$functions" /> function<xsl:if test="$functions &gt; 1">s</xsl:if>
                    </xsl:if>
                </small>
            </xsl:if>
        </dt>
    </xsl:template>

    <xsl:template match="//function[@diff = 'added']">
        <dt>
            <i class="bullet-added">&#160;</i>
            <code>
                <a>
                    <xsl:attribute name="href">
                        <xsl:value-of select="php:function('str_replace', '%line%', string(defn-source[@id = 'source']/@line), php:function('str_replace', '%file%', string(defn-source[@id = 'source']/@file), php:function('str_replace', '%commit%', string(/root/defn[@id = 'source']/defn[@id = 'commit']/@value), string(/root/defn[@id = 'source']/@file-link))))" />
                    </xsl:attribute>
                    <xsl:value-of select="@id" />
                </a>
            </code>
        </dt>
    </xsl:template>

    <xsl:template match="//function[@diff = 'removed']">
        <dt>
            <i class="bullet-removed">&#160;</i>
            <code>
                <a>
                    <xsl:attribute name="href">
                        <xsl:value-of select="php:function('str_replace', '%line%', string(defn-source[@id = 'source']/@line), php:function('str_replace', '%file%', string(defn-source[@id = 'source']/@file), php:function('str_replace', '%commit%', string(/root/defn[@id = 'source']/defn[@id = 'commit']/diff-old/defn[@id = 'commit']/@value), string(/root/defn[@id = 'source']/@file-link))))" />
                    </xsl:attribute>
                    <xsl:value-of select="@id" />
                </a>
            </code>
        </dt>
    </xsl:template>

    <xsl:template match="//function[@diff = 'touched']">
        <dt>
            <i class="bullet-touched">&#160;</i>
            <code>
                <a>
                    <xsl:attribute name="href">
                        <xsl:value-of select="php:function('str_replace', '%line%', string(defn-source[@id = 'source']/@line), php:function('str_replace', '%file%', string(defn-source[@id = 'source']/@file), php:function('str_replace', '%commit%', string(/root/defn[@id = 'source']/defn[@id = 'commit']/@value), string(/root/defn[@id = 'source']/@file-link))))" />
                    </xsl:attribute>
                    <xsl:value-of select="@id" />
                </a>
            </code>
    
            <xsl:variable name="attr_changed" select="count(attr[@diff = 'changed'])" />

            <xsl:if test="$attr_changed">
                &#8211;
                <xsl:apply-templates select="attr" />
            </xsl:if>
        </dt>

        <xsl:variable name="param_touched" select="count(function-param[@diff = 'touched' or @diff = 'touched'])" />

        <xsl:if test="$param_touched">
            <dd>
                params touched:<br />
    
                <ul>
                    <xsl:apply-templates select="function-param" />
                </ul>
            </dd>
        </xsl:if>
    </xsl:template>

    <xsl:template match="//function-param">
        <li>
            <code><xsl:value-of select="@id" /></code>

            <xsl:variable name="attr_touched" select="count(attr[@diff = 'changed'])" />
    
            <xsl:if test="$attr_touched">
                &#8211;
                <xsl:apply-templates select="attr[@diff = 'changed']" />
            </xsl:if>
        </li>
    </xsl:template>

    <xsl:template match="//class[@diff = 'touched']">
        <dt>
            <i class="bullet-touched">&#160;</i>
            <code>
                <a>
                    <xsl:attribute name="href">
                        <xsl:value-of select="php:function('str_replace', '%line%', string(defn-source[@id = 'source']/@line), php:function('str_replace', '%file%', string(defn-source[@id = 'source']/@file), php:function('str_replace', '%commit%', string(/root/defn[@id = 'source']/defn[@id = 'commit']/@value), string(/root/defn[@id = 'source']/@file-link))))" />
                    </xsl:attribute>
                    <xsl:value-of select="@id" />
                </a>
            </code>
        </dt>

        <xsl:variable name="attr" select="count(attr)" />

        <xsl:if test="$attr">
            <dd>
                <xsl:apply-templates select="attr" />
            </dd>
        </xsl:if>

        <xsl:variable name="constant_add" select="count(constant[@diff = 'added'])" />
        <xsl:variable name="constant_removed" select="count(constant[@diff = 'removed'])" />
        <xsl:variable name="constant_touched" select="count(constant[@diff = 'touched'])" />
        
        <xsl:if test="$constant_add or $constant_touched or $constant_removed">
            <dd>
                <dl>
                    <dt>
                        <h3>
                            Constants
                            <small>
                                &#8212;
                                <xsl:if test="$constant_add">
                                    <xsl:value-of select="$constant_add" />
                                    added<xsl:if test="$constant_removed or $constant_touched">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$constant_removed">
                                    <xsl:value-of select="$constant_removed" />
                                    removed<xsl:if test="$constant_touched">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$constant_touched">
                                    <xsl:value-of select="$constant_touched" />
                                    touched
                                </xsl:if>
                            </small>
                        </h3>
                    </dt>
    
                    <dd>
                        <dl>
                            <xsl:apply-templates select="constant[@diff = 'added']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="constant[@diff = 'removed']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="constant[@diff = 'touched']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                        </dl>
                    </dd>
                </dl>
            </dd>
        </xsl:if>

        <xsl:variable name="function_add" select="count(function[@diff = 'added'])" />
        <xsl:variable name="function_removed" select="count(function[@diff = 'removed'])" />
        <xsl:variable name="function_touched" select="count(function[@diff = 'touched'])" />
        
        <xsl:if test="$function_add or $function_touched or $function_removed">
            <dd>
                <dl>
                    <dt>
                        <h3>
                            Functions
                            <small>
                                &#8212;
                                <xsl:if test="$function_add">
                                    <xsl:value-of select="$function_add" />
                                    added<xsl:if test="$function_removed or $function_touched">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$function_removed">
                                    <xsl:value-of select="$function_removed" />
                                    removed<xsl:if test="$function_touched">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$function_touched">
                                    <xsl:value-of select="$function_touched" />
                                    touched
                                </xsl:if>
                            </small>
                        </h3>
                    </dt>
    
                    <dd>
                        <dl>
                            <xsl:apply-templates select="function[@diff = 'added']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="function[@diff = 'removed']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="function[@diff = 'touched']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                        </dl>
                    </dd>
                </dl>
            </dd>
        </xsl:if>
    </xsl:template>

    <xsl:template match="attr[@diff = 'changed']">
        <xsl:choose>
            <xsl:when test="(@value = 'true' or @value = 'false') and (diff-old/attr/@value = 'true' or diff-old/attr/@value = 'false')">
                <xsl:choose>
                    <xsl:when test="@value = 'true'">
                        now
                    </xsl:when>
                    <xsl:otherwise>
                        no longer
                    </xsl:otherwise>
                </xsl:choose>
                <code><xsl:value-of select="@id" /></code>
            </xsl:when>
            <xsl:otherwise>
                <code><xsl:value-of select="@id" /></code>
                is now
                <code><xsl:value-of select="@value" /></code>
                <br />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
