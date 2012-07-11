<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:php="http://php.net/xsl">
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    Comparing
                    <xsl:value-of select="/root/defn[@id = 'source']/defn[@id = 'commit']/diff-old/defn[@id = 'commit']/@friendly" /><!--
                    -->&#8230;<!--
                    --><xsl:value-of select="/root/defn[@id = 'source']/defn[@id = 'commit']/@friendly" />
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

                    h4 {
                        color: #333333;
                        font-size: 12px;
                        padding-top: 1px;
                    }

                    header {
                        border-bottom: #C9C9C9 solid 1px;
                        padding: 14px 12px;
                    }

                    i.bullet-added, i.bullet-touched, i.bullet-deleted {
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

                    i.bullet-deleted {
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

                    small, small a {
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

                <xsl:variable name="const_deleted" select="count(/root/const[@diff = 'deleted'])" />
                <xsl:variable name="const_touched" select="count(/root/const[@diff = 'touched'])" />
                <xsl:variable name="const_added" select="count(/root/const[@diff = 'added'])" />
            
                <xsl:if test="$const_deleted or $const_touched or $const_added">
                    <section>
                        <h2>
                            Constants
                            <small>
                                &#8212;
                                <xsl:if test="$const_deleted">
                                    <xsl:value-of select="$const_deleted" />
                                    deleted<xsl:if test="$const_touched or $const_added">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$const_touched">
                                    <xsl:value-of select="$const_touched" />
                                    touched<xsl:if test="$const_added">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$const_added">
                                    <xsl:value-of select="$const_added" />
                                    added
                                </xsl:if>
                            </small>
                        </h2>

                        <dl>
                            <xsl:apply-templates select="/root/const[@diff = 'deleted']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="/root/const[@diff = 'touched']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="/root/const[@diff = 'added']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                        </dl>
                    </section>
                </xsl:if>

                <xsl:variable name="interface_deleted" select="count(/root/interface[@diff = 'deleted'])" />
                <xsl:variable name="interface_touched" select="count(/root/interface[@diff = 'touched'])" />
                <xsl:variable name="interface_added" select="count(/root/interface[@diff = 'added'])" />
            
                <xsl:if test="$interface_deleted or $interface_touched or $interface_added">
                    <section>
                        <h2>
                            Interfaces
                            <small>
                                &#8212;
                                <xsl:if test="$interface_deleted">
                                    <xsl:value-of select="$interface_deleted" />
                                    deleted<xsl:if test="$interface_touched or $interface_added">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$interface_touched">
                                    <xsl:value-of select="$interface_touched" />
                                    touched<xsl:if test="$interface_added">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$interface_added">
                                    <xsl:value-of select="$interface_added" />
                                    added
                                </xsl:if>
                            </small>
                        </h2>

                        <dl>
                            <xsl:apply-templates select="/root/interface[@diff = 'deleted']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="/root/interface[@diff = 'touched']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="/root/interface[@diff = 'added']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                        </dl>
                    </section>
                </xsl:if>

                <xsl:variable name="class_deleted" select="count(/root/class[@diff = 'deleted'])" />
                <xsl:variable name="class_touched" select="count(/root/class[@diff = 'touched'])" />
                <xsl:variable name="class_added" select="count(/root/class[@diff = 'added'])" />

                <xsl:if test="$class_deleted or $class_touched or $class_added">
                    <section>
                        <h2>
                            Classes
                            <small>
                                &#8212;
                                <xsl:if test="$class_deleted">
                                    <xsl:value-of select="$class_deleted" />
                                    deleted<xsl:if test="$class_touched or $class_added">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$class_touched">
                                    <xsl:value-of select="$class_touched" />
                                    touched<xsl:if test="$class_added">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$class_added">
                                    <xsl:value-of select="$class_added" />
                                    added
                                </xsl:if>
                            </small>
                        </h2>

                        <dl>
                            <xsl:apply-templates select="/root/class[@diff = 'deleted']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="/root/class[@diff = 'touched']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="/root/class[@diff = 'added']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                        </dl>
                    </section>
                </xsl:if>

                <xsl:variable name="function_deleted" select="count(/root/function[@diff = 'deleted'])" />
                <xsl:variable name="function_touched" select="count(/root/function[@diff = 'touched'])" />
                <xsl:variable name="function_added" select="count(/root/function[@diff = 'added'])" />
                
                <xsl:if test="$function_deleted or $function_touched or $function_added">
                    <section>
                        <h2>
                            Functions
                            <small>
                                &#8212;
                                <xsl:if test="$function_deleted">
                                    <xsl:value-of select="$function_deleted" />
                                    deleted<xsl:if test="$function_touched or $function_added">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$function_touched">
                                    <xsl:value-of select="$function_touched" />
                                    touched<xsl:if test="$function_added">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$function_added">
                                    <xsl:value-of select="$function_added" />
                                    added
                                </xsl:if>
                            </small>
                        </h2>

                        <dl>
                            <xsl:apply-templates select="/root/function[@diff = 'deleted']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="/root/function[@diff = 'touched']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="/root/function[@diff = 'added']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                        </dl>
                    </section>
                </xsl:if>

                <footer>
                    <p style="margin-top:0;">
                        Generated by
                        <a href="https://github.com/dpb587/diff-defn.php">dpb587/diff-defn.php</a>
                        &#8212;
                        a tool for comparing application definitions.
                    </p>
                </footer>
            </body>

            <script src="https://ajax.googleapis.com/ajax/libs/mootools/1.4.5/mootools-yui-compressed.js" type="text/javascript"></script>
            <script type="text/javascript">
                window.addEvent('domready', function() {
                    $$('a.dd-more').addEvent(
                        'click',
                        function (e) {
                            e.preventDefault();

                            var t = ('expand' == $(this).get('text')) ? 'collapse' : 'expand';
                            var s = ('expand' == t) ? 'none' : 'block';

                            var d = $(this).set('text', t).getParent('dt');

                            while ((d = d.getNext()) &#38;&#38; ('DD' == d.nodeName)) {
                                d.setStyle('display', s);
                            }
                        }
                    );
                });
            </script>
        </html>
    </xsl:template>

    <xsl:template match="//class-extends">
        <dt>
            <i>
                <xsl:attribute name="class">bullet-<xsl:value-of select="@diff" /></xsl:attribute>
                &#160;
            </i>
            <code><xsl:value-of select="@id" /></code>
        </dt>
    </xsl:template>

    <xsl:template match="//class-implements">
        <dt>
            <i>
                <xsl:attribute name="class">bullet-<xsl:value-of select="@diff" /></xsl:attribute>
                &#160;
            </i>
            <code><xsl:value-of select="@id" /></code>
        </dt>
    </xsl:template>

    <xsl:template match="//const">
        <dt>
            <i>
                <xsl:attribute name="class">bullet-<xsl:value-of select="@diff" /></xsl:attribute>
                &#160;
            </i>
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

    <xsl:template match="//interface">
        <xsl:variable name="v_more_text">
            <xsl:choose>
                <xsl:when test="@diff = 'added'">expand</xsl:when>
                <xsl:when test="@diff = 'deleted'">expand</xsl:when>
                <xsl:otherwise>collapse</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="v_more_style">
            <xsl:choose>
                <xsl:when test="@diff = 'added'">display:none;</xsl:when>
                <xsl:when test="@diff = 'deleted'">display:none;</xsl:when>
                <xsl:otherwise>display:block;</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="c_const" select="count(const)" />
        <xsl:variable name="c_const_deleted" select="count(const[@diff = 'deleted'])" />
        <xsl:variable name="c_const_touched" select="count(const[@diff = 'touched'])" />
        <xsl:variable name="c_const_added" select="count(const[@diff = 'added'])" />

        <xsl:variable name="c_function" select="count(function)" />
        <xsl:variable name="c_function_deleted" select="count(function[@diff = 'deleted'])" />
        <xsl:variable name="c_function_touched" select="count(function[@diff = 'touched'])" />
        <xsl:variable name="c_function_added" select="count(function[@diff = 'added'])" />

        <dt>
            <i>
                <xsl:attribute name="class">bullet-<xsl:value-of select="@diff" /></xsl:attribute>
                &#160;
            </i>
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

            <xsl:if test="$c_const or $c_function">
                <small>
                    &#8211;
                    <xsl:if test="$c_const">
                        <xsl:value-of select="$c_const" /> constant<xsl:if test="$c_const &gt; 1">s</xsl:if><xsl:if test="$functions">, </xsl:if>
                    </xsl:if>
                    <xsl:if test="$c_function">
                        <xsl:value-of select="$c_function" /> function<xsl:if test="$c_function &gt; 1">s</xsl:if>
                    </xsl:if>
                    &#8211;
                    <a class="dd-more" href="#"><xsl:value-of select="$v_more_text" /></a>
                </small>
            </xsl:if>
        </dt>
        
        <xsl:if test="$c_const">
            <dd class="dd-more">
                <xsl:attribute name="style"><xsl:value-of select="$v_more_style" /></xsl:attribute>
                <dl>
                    <dt>
                        <h3>
                            Constants
                            <small>
                                &#8212;
                                <xsl:if test="$c_const_deleted">
                                    <xsl:value-of select="$c_const_deleted" />
                                    deleted<xsl:if test="$c_const_touched or $c_const_added">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$c_const_touched">
                                    <xsl:value-of select="$c_const_touched" />
                                    touched<xsl:if test="$c_const_added">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$c_const_added">
                                    <xsl:value-of select="$c_const_added" />
                                    added
                                </xsl:if>
                            </small>
                        </h3>
                    </dt>
    
                    <dd>
                        <dl>
                            <xsl:apply-templates select="const[@diff = 'deleted']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="const[@diff = 'touched']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="const[@diff = 'added']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                        </dl>
                    </dd>
                </dl>
            </dd>
        </xsl:if>
        
        <xsl:if test="$c_function">
            <dd class="dd-more">
                <xsl:attribute name="style"><xsl:value-of select="$v_more_style" /></xsl:attribute>
                <dl>
                    <dt>
                        <h3>
                            Functions
                            <small>
                                &#8212;
                                <xsl:if test="$c_function_deleted">
                                    <xsl:value-of select="$c_function_deleted" />
                                    deleted<xsl:if test="$c_function_touched or $c_function_added">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$c_function_touched">
                                    <xsl:value-of select="$c_function_touched" />
                                    touched<xsl:if test="$c_function_added">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$c_function_added">
                                    <xsl:value-of select="$c_function_added" />
                                    added
                                </xsl:if>
                            </small>
                        </h3>
                    </dt>
    
                    <dd>
                        <dl>
                            <xsl:apply-templates select="function[@diff = 'deleted']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="function[@diff = 'touched']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="function[@diff = 'added']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                        </dl>
                    </dd>
                </dl>
            </dd>
        </xsl:if>
    </xsl:template>

    <xsl:template match="//function">
        <dt>
            <i>
                <xsl:attribute name="class">bullet-<xsl:value-of select="@diff" /></xsl:attribute>
                &#160;
            </i>
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

            <xsl:variable name="c_attr" select="count(defn-attr)" />
    
            <xsl:if test="$c_attr">
                &#8211;
                <xsl:for-each select="defn-attr">
                    <xsl:if test="position() &gt; 1">, </xsl:if>
                    <xsl:apply-templates select="." />
                </xsl:for-each>
            </xsl:if>
        </dt>

        <xsl:if test="count(function-param[@diff = 'touched'])">
            <dd>
                <dl>
                    <dt>
                        <h4>Parameters</h4>
                    </dt>
                    <dd>
                        <dl>
                            <xsl:apply-templates select="function-param" />
                        </dl>
                    </dd>
                </dl>
            </dd>
        </xsl:if>
    </xsl:template>

    <xsl:template match="//function-param">
        <dt>
            <i>
                <xsl:attribute name="class">bullet-<xsl:value-of select="@diff" /></xsl:attribute>
                &#160;
            </i>
            <code><xsl:value-of select="@id" /></code>

            <xsl:if test="count(defn-attr[@diff = 'changed'])">
                &#8211;
                <xsl:apply-templates select="defn-attr[@diff = 'changed']" />
            </xsl:if>
        </dt>
    </xsl:template>

    <xsl:template match="//class-property">
        <dt>
            <i>
                <xsl:attribute name="class">bullet-<xsl:value-of select="@diff" /></xsl:attribute>
                &#160;
            </i>
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

            <xsl:variable name="c_attr" select="count(defn-attr)" />
    
            <xsl:if test="$c_attr">
                &#8211;
                <xsl:for-each select="defn-attr">
                    <xsl:if test="position() &gt; 1">, </xsl:if>
                    <xsl:apply-templates select="." />
                </xsl:for-each>
            </xsl:if>
        </dt>
    </xsl:template>

    <xsl:template match="//class">
        <xsl:variable name="v_more_text">
            <xsl:choose>
                <xsl:when test="@diff = 'added'">expand</xsl:when>
                <xsl:when test="@diff = 'deleted'">expand</xsl:when>
                <xsl:otherwise>collapse</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="v_more_style">
            <xsl:choose>
                <xsl:when test="@diff = 'added'">display:none;</xsl:when>
                <xsl:when test="@diff = 'deleted'">display:none;</xsl:when>
                <xsl:otherwise>display:block;</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="c_attr" select="count(defn-attr)" />

        <xsl:variable name="c_extends" select="count(class-extends)" />
        <xsl:variable name="c_extends_deleted" select="count(class-extends[@diff = 'deleted'])" />
        <xsl:variable name="c_extends_added" select="count(class-extends[@diff = 'added'])" />

        <xsl:variable name="c_implements" select="count(class-implements)" />
        <xsl:variable name="c_implements_deleted" select="count(class-implements[@diff = 'deleted'])" />
        <xsl:variable name="c_implements_added" select="count(class-implements[@diff = 'added'])" />

        <xsl:variable name="c_const" select="count(const)" />
        <xsl:variable name="c_const_deleted" select="count(const[@diff = 'deleted'])" />
        <xsl:variable name="c_const_touched" select="count(const[@diff = 'touched'])" />
        <xsl:variable name="c_const_added" select="count(const[@diff = 'added'])" />

        <xsl:variable name="c_property" select="count(class-property)" />
        <xsl:variable name="c_property_deleted" select="count(class-property[@diff = 'deleted'])" />
        <xsl:variable name="c_property_touched" select="count(class-property[@diff = 'touched'])" />
        <xsl:variable name="c_property_added" select="count(class-property[@diff = 'added'])" />

        <xsl:variable name="c_function" select="count(function)" />
        <xsl:variable name="c_function_deleted" select="count(function[@diff = 'deleted'])" />
        <xsl:variable name="c_function_touched" select="count(function[@diff = 'touched'])" />
        <xsl:variable name="c_function_added" select="count(function[@diff = 'added'])" />

        <dt>
            <i>
                <xsl:attribute name="class">bullet-<xsl:value-of select="@diff" /></xsl:attribute>
                &#160;
            </i>
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
            <xsl:if test="(@diff = 'added' or @diff = 'deleted') and ($c_const or $c_function)">
                <small>
                    &#8211;
                    <xsl:if test="$c_const">
                        <xsl:value-of select="$c_const" /> constant<xsl:if test="$c_const &gt; 1">s</xsl:if><xsl:if test="$c_property or $c_function">, </xsl:if>
                    </xsl:if>
                    <xsl:if test="$c_property">
                        <xsl:value-of select="$c_property" /> propert<xsl:choose><xsl:when test="$c_property &gt; 1">ies</xsl:when><xsl:otherwise>y</xsl:otherwise></xsl:choose><xsl:if test="$c_property or $c_function">, </xsl:if>
                    </xsl:if>
                    <xsl:if test="$c_function">
                        <xsl:value-of select="$c_function" /> function<xsl:if test="$c_function &gt; 1">s</xsl:if>
                    </xsl:if>
                    &#8211;
                    <a class="dd-more" href="#"><xsl:value-of select="$v_more_text" /></a>
                </small>
            </xsl:if>
        </dt>

        <xsl:if test="$c_attr">
            <dd class="dd-more">
                <xsl:attribute name="style"><xsl:value-of select="$v_more_style" /></xsl:attribute>
                <xsl:apply-templates select="defn-attr" />
            </dd>
        </xsl:if>

        <xsl:if test="$c_extends">
            <dd class="dd-more">
                <xsl:attribute name="style"><xsl:value-of select="$v_more_style" /></xsl:attribute>
                <dl>
                    <dt>
                        <h3>
                            Extends
                            <small>
                                &#8212;
                                <xsl:if test="$c_extends_deleted">
                                    <xsl:value-of select="$c_extends_deleted" />
                                    deleted<xsl:if test="$c_extends_added">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$c_extends_added">
                                    <xsl:value-of select="$c_extends_added" />
                                    added
                                </xsl:if>
                            </small>
                        </h3>
                    </dt>
    
                    <dd>
                        <dl>
                            <xsl:apply-templates select="class-extends[@diff = 'deleted']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="class-extends[@diff = 'added']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                        </dl>
                    </dd>
                </dl>
            </dd>
        </xsl:if>
        
        <xsl:if test="$c_implements">
            <dd class="dd-more">
                <xsl:attribute name="style"><xsl:value-of select="$v_more_style" /></xsl:attribute>
                <dl>
                    <dt>
                        <h3>
                            Implements
                            <small>
                                &#8212;
                                <xsl:if test="$c_implements_deleted">
                                    <xsl:value-of select="$c_implements_deleted" />
                                    deleted<xsl:if test="$c_implements_added">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$c_implements_added">
                                    <xsl:value-of select="$c_implements_added" />
                                    added
                                </xsl:if>
                            </small>
                        </h3>
                    </dt>
        
                    <dd>
                        <dl>
                            <xsl:apply-templates select="class-implements[@diff = 'deleted']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="class-implements[@diff = 'added']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                        </dl>
                    </dd>
                </dl>
            </dd>
        </xsl:if>
        
        <xsl:if test="$c_const">
            <dd class="dd-more">
                <xsl:attribute name="style"><xsl:value-of select="$v_more_style" /></xsl:attribute>
                <dl>
                    <dt>
                        <h3>
                            Constants
                            <small>
                                &#8212;
                                <xsl:if test="$c_const_deleted">
                                    <xsl:value-of select="$c_const_deleted" />
                                    deleted<xsl:if test="$c_const_touched or $c_const_added">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$c_const_touched">
                                    <xsl:value-of select="$c_const_touched" />
                                    touched<xsl:if test="$c_const_added">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$c_const_added">
                                    <xsl:value-of select="$c_const_added" />
                                    added
                                </xsl:if>
                            </small>
                        </h3>
                    </dt>
    
                    <dd>
                        <dl>
                            <xsl:apply-templates select="const[@diff = 'deleted']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="const[@diff = 'touched']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="const[@diff = 'added']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                        </dl>
                    </dd>
                </dl>
            </dd>
        </xsl:if>
        
        <xsl:if test="$c_property">
            <dd class="dd-more">
                <xsl:attribute name="style"><xsl:value-of select="$v_more_style" /></xsl:attribute>
                <dl>
                    <dt>
                        <h3>
                            Properties
                            <small>
                                &#8212;
                                <xsl:if test="$c_property_deleted">
                                    <xsl:value-of select="$c_property_deleted" />
                                    deleted<xsl:if test="$c_property_touched or $c_property_added">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$c_property_touched">
                                    <xsl:value-of select="$c_property_touched" />
                                    touched<xsl:if test="$c_property_added">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$c_property_added">
                                    <xsl:value-of select="$c_property_added" />
                                    added
                                </xsl:if>
                            </small>
                        </h3>
                    </dt>
    
                    <dd>
                        <dl>
                            <xsl:apply-templates select="class-property[@diff = 'deleted']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="class-property[@diff = 'touched']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="class-property[@diff = 'added']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                        </dl>
                    </dd>
                </dl>
            </dd>
        </xsl:if>
        
        <xsl:if test="$c_function">
            <dd class="dd-more">
                <xsl:attribute name="style"><xsl:value-of select="$v_more_style" /></xsl:attribute>
                <dl>
                    <dt>
                        <h3>
                            Functions
                            <small>
                                &#8212;
                                <xsl:if test="$c_function_deleted">
                                    <xsl:value-of select="$c_function_deleted" />
                                    deleted<xsl:if test="$c_function_touched or $c_function_added">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$c_function_touched">
                                    <xsl:value-of select="$c_function_touched" />
                                    touched<xsl:if test="$c_function_added">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$c_function_added">
                                    <xsl:value-of select="$c_function_added" />
                                    added
                                </xsl:if>
                            </small>
                        </h3>
                    </dt>
    
                    <dd>
                        <dl>
                            <xsl:apply-templates select="function[@diff = 'deleted']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="function[@diff = 'touched']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="function[@diff = 'added']">
                                <xsl:sort select="@id" />
                            </xsl:apply-templates>
                        </dl>
                    </dd>
                </dl>
            </dd>
        </xsl:if>
    </xsl:template>

    <xsl:template match="defn-attr[@diff = 'changed']">
        <xsl:choose>
            <xsl:when test="(@value = 'true' or @value = 'false') and (diff-old/defn-attr/@value = 'true' or diff-old/attr/@value = 'false')">
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
                <span style="opacity:0.6;">
                    (was
                    <code><xsl:value-of select="diff-old/defn-attr/@value" /></code>)
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="defn-attr">
        <xsl:choose>
            <xsl:when test="@value = 'true'">
                <code><xsl:value-of select="@id" /></code>
            </xsl:when>
            <xsl:when test="@value = 'false'">
                not <code><xsl:value-of select="@id" /></code>
            </xsl:when>
            <xsl:otherwise>
                <code><xsl:value-of select="@id" /></code>
                <xsl:choose>
                    <xsl:when test="@diff = 'deleted'"> was </xsl:when>
                    <xsl:otherwise> is </xsl:otherwise>
                </xsl:choose>
                <code><xsl:value-of select="@value" /></code>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
