<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
            <head>
                <link href="http://twitter.github.com/bootstrap/assets/css/bootstrap.css" rel="stylesheet" />
            </head>

            <body>
                <div class="container">
                    <div class="page-header">
                        <h2>Definition Changes</h2>
                    </div>

                    <div>
                        <xsl:variable name="class_add" select="count(//class[@diff = 'added'])" />
                        <xsl:variable name="class_changed" select="count(//class[@diff = 'touched'])" />
                        <xsl:variable name="class_removed" select="count(//class[@diff = 'removed'])" />
    
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
                                                <xsl:apply-templates select="//class[@diff = 'added']"/>
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
                                                <xsl:apply-templates select="//class[@diff = 'removed']"/>
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
                                                <xsl:apply-templates select="//class[@diff = 'touched']"/>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                </tbody>
                            </table>
                        </xsl:if>
                    </div>

                    <div>
                        <xsl:variable name="function_add" select="count(//function[@diff = 'added'])" />
                        <xsl:variable name="function_changed" select="count(//function[@diff = 'touched'])" />
                        <xsl:variable name="function_removed" select="count(//function[@diff = 'removed'])" />
                    
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
                    
                            <div class="row">
                                <div class="span6">
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
                                                        <xsl:apply-templates select="//function[@diff = 'added']"/>
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
                                                        <xsl:apply-templates select="//function[@diff = 'removed']"/>
                                                    </td>
                                                </tr>
                                            </xsl:if>
                                            <xsl:apply-templates select="//function[@diff = 'changed']"/>
                                        </tbody>
                                    </table>
                                </div>

                                <div class="span6">
                                    <xsl:apply-templates select="//function[@diff = 'changed']"/>
                                </div>
                            </div>
                        </xsl:if>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="//class[@diff = 'added']">
        <code><xsl:value-of select="@id" /></code><br />
    </xsl:template>

    <xsl:template match="//class[@diff = 'removed']">
        <code><xsl:value-of select="@id" /></code><br />
    </xsl:template>

    <xsl:template match="//function[@diff = 'added']">
        <code><xsl:value-of select="@id" /></code><br />
    </xsl:template>

    <xsl:template match="//function[@diff = 'removed']">
        <code><xsl:value-of select="@id" /></code><br />
    </xsl:template>

    <xsl:template match="//class[@diff = 'touched']">
        <table class="table">
            <tr>
                <td><code><xsl:value-of select="@id" /></code></td>
                <td>
                    <xsl:apply-templates select="attr" />

                    <xsl:variable name="method_add" select="count(//function[@diff = 'added'])" />
                    <xsl:variable name="method_changed" select="count(//function[@diff = 'touched'])" />
                    <xsl:variable name="method_removed" select="count(//function[@diff = 'removed'])" />
                    
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
                    
                        <table class="table">
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
                                <xsl:apply-templates select="function[@diff = 'changed']"/>
                            </tbody>
                        </table>
                    </xsl:if>
                </td>
            </tr>
        </table>
    </xsl:template>

    <xsl:template match="//class[@diff = 'touched']/attr">
        <code><xsl:value-of select="@id" /></code> is now <code><xsl:value-of select="@value" /></code><br />
    </xsl:template>

    <xsl:template match="//class[@diff = 'touched']/function[@diff = 'added']">
        <tr>
            <td style="width:20px;"><span style="background-color:#339933;border-radius:2px;height:18px;padding:2px 3px 0 4px;width:18px;"><i class="icon-plus icon-white" /></span></td>
            <td><code><xsl:value-of select="@id" /></code> method added to <code><xsl:value-of select="parent::node/@id" /></code></td>
        </tr>
    </xsl:template>

    <xsl:template match="//class[@diff = 'touched']/function[@diff = 'removed']">
        <tr>
            <td style="width:20px;"><span style="background-color:#993333;border-radius:2px;height:18px;padding:2px 3px 0 4px;width:18px;"><i class="icon-minus icon-white" /></span></td>
            <td><code><xsl:value-of select="@id" /></code> method removed from <code><xsl:value-of select="parent::node/@id" /></code></td>
        </tr>
    </xsl:template>

    <xsl:template match="//class[@diff = 'touched']/function[@diff = 'touched']/attr[@diff = 'changed']">
        <p>The <code><xsl:value-of select="@id" /></code> for <xsl:value-of select="../../@id" />::<xsl:value-of select="../@id" /> changed to <xsl:value-of select="@value" />.</p>
    </xsl:template>
</xsl:stylesheet>
