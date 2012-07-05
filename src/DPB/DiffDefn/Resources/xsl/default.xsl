<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:php="http://php.net/xsl">
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    Comparing
                    <xsl:value-of select="/root/defn[@id = 'source']/defn[@id = 'commit']/diff-old/defn[@id = 'commit']/@friendly" />
                    &#8230;
                    <xsl:value-of select="/root/defn[@id = 'source']/defn[@id = 'commit']/@friendly" />
                    &#8213;
                    <xsl:value-of select="/root/defn[@id = 'source']/@repository" />
                </title>
                    
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
                        margin-left: 24px;
                    }

                    dl dd dl {
                        margin-left: -12px;
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
                        color: #666666;
                        padding: 14px 12px;
                    }

                    footer a {
                        color: #666666;
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
                        padding: 14px 12px;
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
                        padding: 12px 12px 16px;
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
                        <xsl:choose>
                            <xsl:when test="//root/defn[@id = 'source']/@repository-link">
                                <a>
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="/root/defn[@id = 'source']/@repository-link" />
                                    </xsl:attribute>
                                    <xsl:value-of select="/root/defn[@id = 'source']/@repository-link" />
                                </a>
                                &#8213;
                                comparing
                            </xsl:when>
                            <xsl:otherwise>
                                Comparing
                            </xsl:otherwise>
                        </xsl:choose>
                        <code>
                            <xsl:choose>
                                <xsl:when test="//root/defn[@id = 'source']/@commit-link">
                                    <a>
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="php:function('str_replace', '%commit%', string(/root/defn[@id = 'source']/defn[@id = 'commit']/diff-old/defn[@id = 'commit']/@value), string(/root/defn[@id = 'source']/@commit-link))" />
                                        </xsl:attribute>
                                        <xsl:value-of select="/root/defn[@id = 'source']/defn[@id = 'commit']/diff-old/defn[@id = 'commit']/@friendly" />
                                    </a>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="/root/defn[@id = 'source']/defn[@id = 'commit']/diff-old/defn[@id = 'commit']/@friendly" />
                                </xsl:otherwise>
                            </xsl:choose>
                        </code>
                        &#8230;
                        <code>
                            <xsl:choose>
                                <xsl:when test="//root/defn[@id = 'source']/@commit-link">
                                    <a>
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="php:function('str_replace', '%commit%', string(/root/defn[@id = 'source']/defn[@id = 'commit']/@value), string(/root/defn[@id = 'source']/@commit-link))" />
                                        </xsl:attribute>
                                        <xsl:value-of select="/root/defn[@id = 'source']/defn[@id = 'commit']/@friendly" />
                                    </a>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="/root/defn[@id = 'source']/defn[@id = 'commit']/@friendly" />
                                </xsl:otherwise>
                            </xsl:choose>
                        </code>
                    </p>
                </header>

                <xsl:variable name="const_add" select="count(/root/const[@diff = 'added'])" />
                <xsl:variable name="const_removed" select="count(/root/const[@diff = 'removed'])" />
                <xsl:variable name="const_touched" select="count(/root/const[@diff = 'touched'])" />
            
                <xsl:if test="$const_add or $const_touched or $const_removed">
                    <section>
                        <h2>
                            Constants
                            <small>
                                &#8212;
                                <xsl:if test="$const_add">
                                    <xsl:value-of select="$const_add" />
                                    added<xsl:if test="$const_removed or $const_touched">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$const_removed">
                                    <xsl:value-of select="$const_removed" />
                                    removed<xsl:if test="$const_touched">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$const_touched">
                                    <xsl:value-of select="$const_touched" />
                                    touched
                                </xsl:if>
                            </small>
                        </h2>

                        <dl>
                            <xsl:apply-templates select="/root/const[@diff = 'added']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="/root/const[@diff = 'removed']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="/root/const[@diff = 'touched']">
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
                        Generated by
                        <a href="https://github.com/dpb587/diff-defn.php/">dpb587/diff-defn.php</a>
                        &#8212;
                        a tool for comparing application definitions.
                    </p>
                </footer>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="//class-extends[@diff = 'added']">
        <dt>
            <i class="bullet-added">&#160;</i>
            <code>
                <xsl:value-of select="@id" />
            </code>
        </dt>
    </xsl:template>

    <xsl:template match="//class-extends[@diff = 'removed']">
        <dt>
            <i class="bullet-removed">&#160;</i>
            <code>
                <xsl:value-of select="@id" />
            </code>
        </dt>
    </xsl:template>

    <xsl:template match="//class-implements[@diff = 'added']">
        <dt>
            <i class="bullet-added">&#160;</i>
            <code>
                <xsl:value-of select="@id" />
            </code>
        </dt>
    </xsl:template>

    <xsl:template match="//class-implements[@diff = 'removed']">
        <dt>
            <i class="bullet-removed">&#160;</i>
            <code>
                <xsl:value-of select="@id" />
            </code>
        </dt>
    </xsl:template>

    <xsl:template match="//const[@diff = 'added']">
        <dt>
            <i class="bullet-added">&#160;</i>
            <code>
                <xsl:choose>
                    <xsl:when test="/root/defn[@id = 'source']/@file-link">
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="php:function('str_replace', '%line%', string(defn-source[@id = 'source']/@line), php:function('str_replace', '%file%', string(defn-source[@id = 'source']/@file), php:function('str_replace', '%commit%', string(/root/defn[@id = 'source']/defn[@id = 'commit']/@value), string(/root/defn[@id = 'source']/@file-link))))" />
                            </xsl:attribute>
                            <xsl:value-of select="@id" />
                        </a>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="@id" />
                    </xsl:otherwise>
                </xsl:choose>
            </code>
        </dt>
    </xsl:template>

    <xsl:template match="//const[@diff = 'removed']">
        <dt>
            <i class="bullet-removed">&#160;</i>
            <code>
                <xsl:choose>
                    <xsl:when test="/root/defn[@id = 'source']/@file-link">
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="php:function('str_replace', '%line%', string(defn-source[@id = 'source']/@line), php:function('str_replace', '%file%', string(defn-source[@id = 'source']/@file), php:function('str_replace', '%commit%', string(/root/defn[@id = 'source']/defn[@id = 'commit']/diff-old/defn[@id = 'commit']/@value), string(/root/defn[@id = 'source']/@file-link))))" />
                            </xsl:attribute>
                            <xsl:value-of select="@id" />
                        </a>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="@id" />
                    </xsl:otherwise>
                </xsl:choose>
            </code>
        </dt>
    </xsl:template>

    <xsl:template match="//interface[@diff = 'added']">
        <dt>
            <i class="bullet-added">&#160;</i>
            <code>
                <xsl:choose>
                    <xsl:when test="/root/defn[@id = 'source']/@file-link">
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="php:function('str_replace', '%line%', string(defn-source[@id = 'source']/@line), php:function('str_replace', '%file%', string(defn-source[@id = 'source']/@file), php:function('str_replace', '%commit%', string(/root/defn[@id = 'source']/defn[@id = 'commit']/@value), string(/root/defn[@id = 'source']/@file-link))))" />
                            </xsl:attribute>
                            <xsl:value-of select="@id" />
                        </a>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="@id" />
                    </xsl:otherwise>
                </xsl:choose>
            </code>

            <xsl:variable name="consts" select="count(const)" />
            <xsl:variable name="functions" select="count(function)" />

            <xsl:if test="$consts or $functions">
                <small>
                    &#8211;
                    <xsl:if test="$consts">
                        <xsl:value-of select="$consts" /> constant<xsl:if test="$consts &gt; 1">s</xsl:if><xsl:if test="$functions">, </xsl:if>
                    </xsl:if>
                    <xsl:if test="$functions">
                        <xsl:value-of select="$functions" /> function<xsl:if test="$functions &gt; 1">s</xsl:if>
                    </xsl:if>
                </small>
            </xsl:if>
        </dt>
    </xsl:template>

    <xsl:template match="//interface[@diff = 'removed']">
        <dt>
            <i class="bullet-removed">&#160;</i>
            <code>
                <xsl:choose>
                    <xsl:when test="/root/defn[@id = 'source']/@file-link">
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="php:function('str_replace', '%line%', string(defn-source[@id = 'source']/@line), php:function('str_replace', '%file%', string(defn-source[@id = 'source']/@file), php:function('str_replace', '%commit%', string(/root/defn[@id = 'source']/defn[@id = 'commit']/diff-old/defn[@id = 'commit']/@value), string(/root/defn[@id = 'source']/@file-link))))" />
                            </xsl:attribute>
                            <xsl:value-of select="@id" />
                        </a>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="@id" />
                    </xsl:otherwise>
                </xsl:choose>
            </code>

            <xsl:variable name="consts" select="count(const)" />
            <xsl:variable name="functions" select="count(function)" />

            <xsl:if test="$consts or $functions">
                <small>
                    &#8211;
                    <xsl:if test="$consts">
                        <xsl:value-of select="$consts" /> constant<xsl:if test="$consts &gt; 1">s</xsl:if><xsl:if test="$functions">, </xsl:if>
                    </xsl:if>
                    <xsl:if test="$functions">
                        <xsl:value-of select="$functions" /> function<xsl:if test="$functions &gt; 1">s</xsl:if>
                    </xsl:if>
                </small>
            </xsl:if>
        </dt>
    </xsl:template>

    <xsl:template match="//class[@diff = 'added']">
        <dt>
            <i class="bullet-added">&#160;</i>
            <code>
                <xsl:choose>
                    <xsl:when test="/root/defn[@id = 'source']/@file-link">
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="php:function('str_replace', '%line%', string(defn-source[@id = 'source']/@line), php:function('str_replace', '%file%', string(defn-source[@id = 'source']/@file), php:function('str_replace', '%commit%', string(/root/defn[@id = 'source']/defn[@id = 'commit']/@value), string(/root/defn[@id = 'source']/@file-link))))" />
                            </xsl:attribute>
                            <xsl:value-of select="@id" />
                        </a>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="@id" />
                    </xsl:otherwise>
                </xsl:choose>
            </code>

            <xsl:variable name="consts" select="count(const)" />
            <xsl:variable name="functions" select="count(function)" />

            <xsl:if test="$consts or $functions">
                <small>
                    &#8211;
                    <xsl:if test="$consts">
                        <xsl:value-of select="$consts" /> constant<xsl:if test="$consts &gt; 1">s</xsl:if><xsl:if test="$functions">, </xsl:if>
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
                <xsl:choose>
                    <xsl:when test="/root/defn[@id = 'source']/@file-link">
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="php:function('str_replace', '%line%', string(defn-source[@id = 'source']/@line), php:function('str_replace', '%file%', string(defn-source[@id = 'source']/@file), php:function('str_replace', '%commit%', string(/root/defn[@id = 'source']/defn[@id = 'commit']/diff-old/defn[@id = 'commit']/@value), string(/root/defn[@id = 'source']/@file-link))))" />
                            </xsl:attribute>
                            <xsl:value-of select="@id" />
                        </a>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="@id" />
                    </xsl:otherwise>
                </xsl:choose>
            </code>

            <xsl:variable name="consts" select="count(const)" />
            <xsl:variable name="functions" select="count(function)" />

            <xsl:if test="$consts or $functions">
                <small>
                    &#8211;
                    <xsl:if test="$consts">
                        <xsl:value-of select="$consts" /> constant<xsl:if test="$consts &gt; 1">s</xsl:if><xsl:if test="$functions">, </xsl:if>
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
                <xsl:choose>
                    <xsl:when test="/root/defn[@id = 'source']/@file-link">
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="php:function('str_replace', '%line%', string(defn-source[@id = 'source']/@line), php:function('str_replace', '%file%', string(defn-source[@id = 'source']/@file), php:function('str_replace', '%commit%', string(/root/defn[@id = 'source']/defn[@id = 'commit']/@value), string(/root/defn[@id = 'source']/@file-link))))" />
                            </xsl:attribute>
                            <xsl:value-of select="@id" />
                        </a>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="@id" />
                    </xsl:otherwise>
                </xsl:choose>
            </code>
        </dt>
    </xsl:template>

    <xsl:template match="//function[@diff = 'removed']">
        <dt>
            <i class="bullet-removed">&#160;</i>
            <code>
                <xsl:choose>
                    <xsl:when test="/root/defn[@id = 'source']/@file-link">
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="php:function('str_replace', '%line%', string(defn-source[@id = 'source']/@line), php:function('str_replace', '%file%', string(defn-source[@id = 'source']/@file), php:function('str_replace', '%commit%', string(/root/defn[@id = 'source']/defn[@id = 'commit']/diff-old/defn[@id = 'commit']/@value), string(/root/defn[@id = 'source']/@file-link))))" />
                            </xsl:attribute>
                            <xsl:value-of select="@id" />
                        </a>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="@id" />
                    </xsl:otherwise>
                </xsl:choose>
            </code>
        </dt>
    </xsl:template>

    <xsl:template match="//function[@diff = 'touched']">
        <dt>
            <i class="bullet-touched">&#160;</i>
            <code>
                <xsl:choose>
                    <xsl:when test="/root/defn[@id = 'source']/@file-link">
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="php:function('str_replace', '%line%', string(defn-source[@id = 'source']/@line), php:function('str_replace', '%file%', string(defn-source[@id = 'source']/@file), php:function('str_replace', '%commit%', string(/root/defn[@id = 'source']/defn[@id = 'commit']/@value), string(/root/defn[@id = 'source']/@file-link))))" />
                            </xsl:attribute>
                            <xsl:value-of select="@id" />
                        </a>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="@id" />
                    </xsl:otherwise>
                </xsl:choose>
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
                <xsl:choose>
                    <xsl:when test="/root/defn[@id = 'source']/@file-link">
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="php:function('str_replace', '%line%', string(defn-source[@id = 'source']/@line), php:function('str_replace', '%file%', string(defn-source[@id = 'source']/@file), php:function('str_replace', '%commit%', string(/root/defn[@id = 'source']/defn[@id = 'commit']/@value), string(/root/defn[@id = 'source']/@file-link))))" />
                            </xsl:attribute>
                            <xsl:value-of select="@id" />
                        </a>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="@id" />
                    </xsl:otherwise>
                </xsl:choose>
            </code>
        </dt>

        <xsl:variable name="attr" select="count(attr)" />

        <xsl:if test="$attr">
            <dd>
                <xsl:apply-templates select="attr" />
            </dd>
        </xsl:if>

        <xsl:variable name="extends_added" select="count(class-extends[@diff = 'added'])" />
        <xsl:variable name="extends_removed" select="count(class-extends[@diff = 'removed'])" />

        <xsl:if test="$extends_added or $extends_removed">
            <dd>
                <dl>
                    <dt>
                        <h3>
                            Extends
                            <small>
                                &#8212;
                                <xsl:if test="$extends_added">
                                    <xsl:value-of select="$extends_added" />
                                    added<xsl:if test="$extends_removed">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$extends_removed">
                                    <xsl:value-of select="$extends_removed" />
                                    removed
                                </xsl:if>
                            </small>
                        </h3>
                    </dt>
    
                    <dd>
                        <dl>
                            <xsl:apply-templates select="class-extends[@diff = 'added']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="class-extends[@diff = 'removed']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                        </dl>
                    </dd>
                </dl>
            </dd>
        </xsl:if>

        <xsl:variable name="implements_added" select="count(class-implements[@diff = 'added'])" />
        <xsl:variable name="implements_removed" select="count(class-implements[@diff = 'removed'])" />
        
        <xsl:if test="$implements_added or $implements_removed">
            <dd>
                <dl>
                    <dt>
                        <h3>
                            Implements
                            <small>
                                &#8212;
                                <xsl:if test="$implements_added">
                                    <xsl:value-of select="$implements_added" />
                                    added<xsl:if test="$implements_removed">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$implements_removed">
                                    <xsl:value-of select="$implements_removed" />
                                    removed
                                </xsl:if>
                            </small>
                        </h3>
                    </dt>
        
                    <dd>
                        <dl>
                            <xsl:apply-templates select="class-implements[@diff = 'added']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="class-implements[@diff = 'removed']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                        </dl>
                    </dd>
                </dl>
            </dd>
        </xsl:if>

        <xsl:variable name="const_add" select="count(const[@diff = 'added'])" />
        <xsl:variable name="const_removed" select="count(const[@diff = 'removed'])" />
        <xsl:variable name="const_touched" select="count(const[@diff = 'touched'])" />
        
        <xsl:if test="$const_add or $const_touched or $const_removed">
            <dd>
                <dl>
                    <dt>
                        <h3>
                            Constants
                            <small>
                                &#8212;
                                <xsl:if test="$const_add">
                                    <xsl:value-of select="$const_add" />
                                    added<xsl:if test="$const_removed or $const_touched">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$const_removed">
                                    <xsl:value-of select="$const_removed" />
                                    removed<xsl:if test="$const_touched">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$const_touched">
                                    <xsl:value-of select="$const_touched" />
                                    touched
                                </xsl:if>
                            </small>
                        </h3>
                    </dt>
    
                    <dd>
                        <dl>
                            <xsl:apply-templates select="const[@diff = 'added']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="const[@diff = 'removed']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="const[@diff = 'touched']">
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
                changed to
                <code><xsl:value-of select="@value" /></code>
                (from
                <code><xsl:value-of select="diff-old/attr/@value" /></code>)
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>