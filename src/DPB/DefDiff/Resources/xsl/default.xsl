<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:php="http://php.net/xsl">
    <xsl:template match="/">
        <html>
            <head>
                <link href="http://twitter.github.com/bootstrap/assets/css/bootstrap.css" rel="stylesheet" />
            </head>

            <body>
                <div class="container" style="padding-top:10px;">
                    <div class="page-header">
                        <h1><xsl:value-of select="/root/defn[@id = 'source']/@repository" /></h1>

                        <p style="margin-top:4px;">
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
                    </div>

                    <div>
                        <xsl:variable name="constant_add" select="count(/root/constant[@diff = 'added'])" />
                        <xsl:variable name="constant_changed" select="count(/root/constant[@diff = 'touched'])" />
                        <xsl:variable name="constant_removed" select="count(/root/constant[@diff = 'removed'])" />
                    
                        <xsl:if test="$constant_add or $constant_changed or $constant_removed">
                            <h3>
                                Constants
                                <small>
                                    &#8212;
                                    <xsl:if test="$constant_add">
                                        <xsl:value-of select="$constant_add" />
                                        added<xsl:if test="$constant_removed or $constant_changed">, </xsl:if>
                                    </xsl:if>
                                    <xsl:if test="$constant_removed">
                                        <xsl:value-of select="$constant_removed" />
                                        removed<xsl:if test="$constant_changed">, </xsl:if>
                                    </xsl:if>
                                    <xsl:if test="$constant_changed">
                                        <xsl:value-of select="$constant_changed" />
                                        changed
                                    </xsl:if>
                                </small>
                            </h3>
                    
                            <table class="table">
                                <tbody>
                                    <xsl:if test="$constant_add">
                                        <tr>
                                            <td style="width:18px;">
                                                <span style="background-color:#339933;border-radius:2px;height:18px;padding:2px 3px 0 4px;width:18px;">
                                                    <i class="icon-plus icon-white" />
                                                </span>
                                            </td>
                                            <td style="line-height:24px;">
                                                <xsl:apply-templates select="/root/constant[@diff = 'added']"/>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    <xsl:if test="$constant_removed">
                                        <tr>
                                            <td style="width:18px;">
                                                <span style="background-color:#993333;border-radius:2px;height:18px;padding:2px 3px 0 4px;width:18px;">
                                                    <i class="icon-minus icon-white" />
                                                </span>
                                            </td>
                                            <td style="line-height:24px;">
                                                <xsl:apply-templates select="/root/constant[@diff = 'removed']"/>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    <xsl:if test="$constant_changed">
                                        <tr>
                                            <td style="width:18px;">
                                                <span style="background-color:#CCAA55;border-radius:2px;height:18px;padding:2px 3px 0 4px;width:18px;">
                                                    <i class="icon-edit icon-white" />
                                                </span>
                                            </td>
                                            <td style="line-height:24px;padding:0;">
                                                <xsl:apply-templates select="/root/constant[@diff = 'touched']"/>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                </tbody>
                            </table>
                        </xsl:if>
                    </div>

                    <div>
                        <xsl:variable name="interface_add" select="count(/root/interface[@diff = 'added'])" />
                        <xsl:variable name="interface_changed" select="count(/root/interface[@diff = 'touched'])" />
                        <xsl:variable name="interface_removed" select="count(/root/interface[@diff = 'removed'])" />
                    
                        <xsl:if test="$interface_add or $interface_changed or $interface_removed">
                            <h3>
                                Interfaces
                                <small>
                                    &#8212;
                                    <xsl:if test="$interface_add">
                                        <xsl:value-of select="$interface_add" />
                                        added<xsl:if test="$interface_removed or $interface_changed">, </xsl:if>
                                    </xsl:if>
                                    <xsl:if test="$interface_removed">
                                        <xsl:value-of select="$interface_removed" />
                                        removed<xsl:if test="$interface_changed">, </xsl:if>
                                    </xsl:if>
                                    <xsl:if test="$interface_changed">
                                        <xsl:value-of select="$interface_changed" />
                                        changed
                                    </xsl:if>
                                </small>
                            </h3>
                    
                            <table class="table">
                                <tbody>
                                    <xsl:if test="$interface_add">
                                        <tr>
                                            <td style="width:18px;">
                                                <span style="background-color:#339933;border-radius:2px;height:18px;padding:2px 3px 0 4px;width:18px;">
                                                    <i class="icon-plus icon-white" />
                                                </span>
                                            </td>
                                            <td style="line-height:24px;">
                                                <xsl:apply-templates select="/root/interface[@diff = 'added']"/>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    <xsl:if test="$interface_removed">
                                        <tr>
                                            <td style="width:18px;">
                                                <span style="background-color:#993333;border-radius:2px;height:18px;padding:2px 3px 0 4px;width:18px;">
                                                    <i class="icon-minus icon-white" />
                                                </span>
                                            </td>
                                            <td style="line-height:24px;">
                                                <xsl:apply-templates select="/root/interface[@diff = 'removed']"/>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    <xsl:if test="$interface_changed">
                                        <tr>
                                            <td style="width:18px;">
                                                <span style="background-color:#CCAA55;border-radius:2px;height:18px;padding:2px 3px 0 4px;width:18px;">
                                                    <i class="icon-edit icon-white" />
                                                </span>
                                            </td>
                                            <td style="line-height:24px;padding:0;">
                                                <xsl:apply-templates select="/root/interface[@diff = 'touched']"/>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                </tbody>
                            </table>
                        </xsl:if>
                    </div>

                    <div>
                        <xsl:variable name="class_add" select="count(/root/class[@diff = 'added'])" />
                        <xsl:variable name="class_changed" select="count(/root/class[@diff = 'touched'])" />
                        <xsl:variable name="class_removed" select="count(/root/class[@diff = 'removed'])" />
    
                        <xsl:if test="$class_add or $class_changed or $class_removed">
                            <h3>
                                Classes
                                <small>
                                    &#8212;
                                    <xsl:if test="$class_add">
                                        <xsl:value-of select="$class_add" />
                                        added<xsl:if test="$class_removed or $class_changed">, </xsl:if>
                                    </xsl:if>
                                    <xsl:if test="$class_removed">
                                        <xsl:value-of select="$class_removed" />
                                        removed<xsl:if test="$class_changed">, </xsl:if>
                                    </xsl:if>
                                    <xsl:if test="$class_changed">
                                        <xsl:value-of select="$class_changed" />
                                        changed
                                    </xsl:if>
                                </small>
                            </h3>

                            <table class="table">
                                <tbody>
                                    <xsl:if test="$class_add">
                                        <tr>
                                            <td style="width:18px;">
                                                <span style="background-color:#339933;border-radius:2px;height:18px;padding:2px 3px 0 4px;width:18px;">
                                                    <i class="icon-plus icon-white" />
                                                </span>
                                            </td>
                                            <td style="line-height:24px;">
                                                <xsl:apply-templates select="/root/class[@diff = 'added']"/>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    <xsl:if test="$class_removed">
                                        <tr>
                                            <td style="width:18px;">
                                                <span style="background-color:#993333;border-radius:2px;height:18px;padding:2px 3px 0 4px;width:18px;">
                                                    <i class="icon-minus icon-white" />
                                                </span>
                                            </td>
                                            <td style="line-height:24px;">
                                                <xsl:apply-templates select="/root/class[@diff = 'removed']"/>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    <xsl:if test="$class_changed">
                                        <tr>
                                            <td style="width:18px;">
                                                <span style="background-color:#CCAA55;border-radius:2px;height:18px;padding:2px 3px 0 4px;width:18px;">
                                                    <i class="icon-edit icon-white" />
                                                </span>
                                            </td>
                                            <td style="line-height:24px;padding:0;">
                                                <xsl:apply-templates select="/root/class[@diff = 'touched']"/>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                </tbody>
                            </table>
                        </xsl:if>
                    </div>

                    <div>
                        <xsl:variable name="function_add" select="count(/root/function[@diff = 'added'])" />
                        <xsl:variable name="function_changed" select="count(/root/function[@diff = 'touched'])" />
                        <xsl:variable name="function_removed" select="count(/root/function[@diff = 'removed'])" />
                    
                        <xsl:if test="$function_add or $function_changed or $function_removed">
                            <h3>
                                Functions
                                <small>
                                    &#8212;
                                    <xsl:if test="$function_add">
                                        <xsl:value-of select="$function_add" />
                                        added<xsl:if test="$function_removed or $function_changed">, </xsl:if>
                                    </xsl:if>
                                    <xsl:if test="$function_removed">
                                        <xsl:value-of select="$function_removed" />
                                        removed<xsl:if test="$function_changed">, </xsl:if>
                                    </xsl:if>
                                    <xsl:if test="$function_changed">
                                        <xsl:value-of select="$function_changed" />
                                        changed
                                    </xsl:if>
                                </small>
                            </h3>

                            <table class="table">
                                <tbody>
                                    <xsl:if test="$function_add">
                                        <tr>
                                            <td style="width:18px;">
                                                <span style="background-color:#339933;border-radius:2px;height:18px;padding:2px 3px 0 4px;width:18px;">
                                                    <i class="icon-plus icon-white" />
                                                </span>
                                            </td>
                                            <td style="line-height:24px;">
                                                <xsl:apply-templates select="/root/function[@diff = 'added']"/>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    <xsl:if test="$function_removed">
                                        <tr>
                                            <td style="width:18px;">
                                                <span style="background-color:#993333;border-radius:2px;height:18px;padding:2px 3px 0 4px;width:18px;">
                                                    <i class="icon-minus icon-white" />
                                                </span>
                                            </td>
                                            <td style="line-height:24px;">
                                                <xsl:apply-templates select="/root/function[@diff = 'removed']"/>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    <xsl:if test="$function_changed">
                                        <tr>
                                            <td style="width:18px;">
                                                <span style="background-color:#CCAA55;border-radius:2px;height:18px;padding:2px 3px 0 4px;width:18px;">
                                                    <i class="icon-edit icon-white" />
                                                </span>
                                            </td>
                                            <td style="line-height:24px;padding:0;">
                                                <xsl:apply-templates select="/root/function[@diff = 'touched']"/>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                </tbody>
                            </table>
                        </xsl:if>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="//constant[@diff = 'added']">
        <code>
            <a>
                <xsl:attribute name="href">
                    <xsl:value-of select="php:function('str_replace', '%line%', string(defn-source[@id = 'source']/@line), php:function('str_replace', '%file%', string(defn-source[@id = 'source']/@file), php:function('str_replace', '%commit%', string(/root/defn[@id = 'source']/defn[@id = 'commit']/@value), string(/root/defn[@id = 'source']/@file-link))))" />
                </xsl:attribute>
                <xsl:value-of select="@id" />
            </a>
        </code>
        <br />
    </xsl:template>

    <xsl:template match="//constant[@diff = 'removed']">
        <code>
            <a>
                <xsl:attribute name="href">
                    <xsl:value-of select="php:function('str_replace', '%line%', string(defn-source[@id = 'source']/@line), php:function('str_replace', '%file%', string(defn-source[@id = 'source']/@file), php:function('str_replace', '%commit%', string(/root/defn[@id = 'source']/defn[@id = 'commit']/diff-old/defn[@id = 'commit']/@value), string(/root/defn[@id = 'source']/@file-link))))" />
                </xsl:attribute>
                <xsl:value-of select="@id" />
            </a>
        </code>
        <br />
    </xsl:template>

    <xsl:template match="//class[@diff = 'added']">
        <code>
            <a>
                <xsl:attribute name="href">
                    <xsl:value-of select="php:function('str_replace', '%line%', string(defn-source[@id = 'source']/@line), php:function('str_replace', '%file%', string(defn-source[@id = 'source']/@file), php:function('str_replace', '%commit%', string(/root/defn[@id = 'source']/defn[@id = 'commit']/@value), string(/root/defn[@id = 'source']/@file-link))))" />
                </xsl:attribute>
                <xsl:value-of select="@id" />
            </a>
        </code>
        <br />
    </xsl:template>

    <xsl:template match="//class[@diff = 'removed']">
        <code>
            <a>
                <xsl:attribute name="href">
                    <xsl:value-of select="php:function('str_replace', '%line%', string(defn-source[@id = 'source']/@line), php:function('str_replace', '%file%', string(defn-source[@id = 'source']/@file), php:function('str_replace', '%commit%', string(/root/defn[@id = 'source']/defn[@id = 'commit']/diff-old/defn[@id = 'commit']/@value), string(/root/defn[@id = 'source']/@file-link))))" />
                </xsl:attribute>
                <xsl:value-of select="@id" />
            </a>
        </code>
        <br />
    </xsl:template>

    <xsl:template match="//function[@diff = 'added']">
        <code>
            <a>
                <xsl:attribute name="href">
                    <xsl:value-of select="php:function('str_replace', '%line%', string(defn-source[@id = 'source']/@line), php:function('str_replace', '%file%', string(defn-source[@id = 'source']/@file), php:function('str_replace', '%commit%', string(/root/defn[@id = 'source']/defn[@id = 'commit']/@value), string(/root/defn[@id = 'source']/@file-link))))" />
                </xsl:attribute>
                <xsl:value-of select="@id" />
            </a>
        </code>
        <br />
    </xsl:template>

    <xsl:template match="//function[@diff = 'removed']">
        <code>
            <a>
                <xsl:attribute name="href">
                    <xsl:value-of select="php:function('str_replace', '%line%', string(defn-source[@id = 'source']/@line), php:function('str_replace', '%file%', string(defn-source[@id = 'source']/@file), php:function('str_replace', '%commit%', string(/root/defn[@id = 'source']/defn[@id = 'commit']/diff-old/defn[@id = 'commit']/@value), string(/root/defn[@id = 'source']/@file-link))))" />
                </xsl:attribute>
                <xsl:value-of select="@id" />
            </a>
        </code>
        <br />
    </xsl:template>

    <xsl:template match="//function[@diff = 'touched']">
        <div>
            <code>
                <a>
                    <xsl:attribute name="href">
                        <xsl:value-of select="php:function('str_replace', '%line%', string(defn-source[@id = 'source']/@line), php:function('str_replace', '%file%', string(defn-source[@id = 'source']/@file), php:function('str_replace', '%commit%', string(/root/defn[@id = 'source']/defn[@id = 'commit']/@value), string(/root/defn[@id = 'source']/@file-link))))" />
                    </xsl:attribute>
                    <xsl:value-of select="@id" />
                </a>
            </code>
    
            <xsl:variable name="attr_changed" select="count(attr[@diff = 'changed'])" />
            <xsl:variable name="param_changed" select="count(function-param[@diff = 'changed' or @diff = 'touched'])" />
    
            <xsl:if test="$attr_changed">
                &#8211;
                <xsl:apply-templates select="attr" /><xsl:if test="$param_changed">; </xsl:if>
            </xsl:if>
    
            <xsl:if test="$param_changed">
                params changed:<br />
    
                <ul>
                    <xsl:apply-templates select="function-param" />
                </ul>
            </xsl:if>
        </div>
    </xsl:template>

    <xsl:template match="//function-param">
        <li>
            <code><xsl:value-of select="@id" /></code>

            <xsl:variable name="attr_changed" select="count(attr[@diff = 'changed'])" />
    
            <xsl:if test="$attr_changed">
                &#8211;
                <xsl:apply-templates select="attr" />
            </xsl:if>
        </li>
    </xsl:template>

    <xsl:template match="//class[@diff = 'touched']">
        <table class="table">
            <tr>
                <td style="width:40%;">
                    <code>
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="php:function('str_replace', '%line%', string(defn-source[@id = 'source']/@line), php:function('str_replace', '%file%', string(defn-source[@id = 'source']/@file), php:function('str_replace', '%commit%', string(/root/defn[@id = 'source']/defn[@id = 'commit']/@value), string(/root/defn[@id = 'source']/@file-link))))" />
                            </xsl:attribute>
                            <xsl:value-of select="@id" />
                        </a>
                    </code>
                    <xsl:apply-templates select="attr" />
                </td>
                <td>
                    <xsl:variable name="method_add" select="count(function[@diff = 'added'])" />
                    <xsl:variable name="method_changed" select="count(function[@diff = 'touched'])" />
                    <xsl:variable name="method_removed" select="count(function[@diff = 'removed'])" />
                    
                    <xsl:if test="$method_add or $method_changed or $method_removed">
                        <h4>
                            Methods
                            <small>
                                &#8212;
                                <xsl:if test="$method_add">
                                    <xsl:value-of select="$method_add" />
                                    added<xsl:if test="$method_removed or $method_changed">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$method_removed">
                                    <xsl:value-of select="$method_removed" />
                                    removed<xsl:if test="$method_changed">, </xsl:if>
                                </xsl:if>
                                <xsl:if test="$method_changed">
                                    <xsl:value-of select="$method_changed" />
                                    changed
                                </xsl:if>
                            </small>
                        </h4>
                    
                        <table class="table" style="margin-top:6px;">
                            <tbody>
                                <xsl:if test="$method_add">
                                    <tr>
                                        <td style="width:18px;">
                                            <span style="background-color:#339933;border-radius:2px;height:18px;padding:2px 3px 0 4px;width:18px;">
                                                <i class="icon-plus icon-white" />
                                            </span>
                                        </td>
                                        <td style="line-height:24px;">
                                            <xsl:apply-templates select="function[@diff = 'added']"/>
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="$method_removed">
                                    <tr>
                                        <td style="width:18px;">
                                            <span style="background-color:#993333;border-radius:2px;height:18px;padding:2px 3px 0 4px;width:18px;">
                                                <i class="icon-minus icon-white" />
                                            </span>
                                        </td>
                                        <td style="line-height:24px;">
                                            <xsl:apply-templates select="function[@diff = 'removed']"/>
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="$method_changed">
                                    <tr>
                                        <td style="width:18px;">
                                            <span style="background-color:#CCAA55;border-radius:2px;height:18px;padding:2px 3px 0 4px;width:18px;">
                                                <i class="icon-edit icon-white" />
                                            </span>
                                        </td>
                                        <td style="line-height:24px;">
                                            <xsl:apply-templates select="function[@diff = 'touched']"/>
                                        </td>
                                    </tr>
                                </xsl:if>
                            </tbody>
                        </table>
                    </xsl:if>
                </td>
            </tr>
        </table>
    </xsl:template>

    <xsl:template match="attr[@diff = 'changed']">
        <code><xsl:value-of select="@id" /></code> is now <code><xsl:value-of select="@value" /></code><br />
    </xsl:template>
</xsl:stylesheet>
