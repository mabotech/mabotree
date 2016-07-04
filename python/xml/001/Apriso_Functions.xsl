<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<!-- _______________________________________________________ GetLotSerialTrack ___________________________________________________________-->
	<!--  0 - not lot, serial or inspection  
			1 - Lot track only
			3 - serial track only
			5 - Inspection only
			4 - both serial and lot track
			6 - both Lot and Inspection
			8 - both serial and inspection
			9 - serial, lot and inspection
	-->
	<xsl:template match="*">
		<xsl:for-each select=".">
			<xsl:call-template name="GetLotSerialTrack">
				<xsl:with-param name="XCHPF" select="."/>
				<xsl:with-param name="SERNP" select="."/>
				<xsl:with-param name="INSMK" select="."/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="GetLotSerialTrack">
		<xsl:param name="XCHPF" select="."/>
		<xsl:param name="SERNP" select="."/>
		<xsl:param name="INSMK" select="."/>
		<xsl:variable name="ResultLot">
			<xsl:choose>
				<xsl:when test="$XCHPF='X'">
					<xsl:value-of select="1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="ResultSerial">
			<xsl:choose>
				<xsl:when test="string-length($SERNP)>0">
					<xsl:value-of select="3"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="ResultInspection">
			<xsl:choose>
				<xsl:when test="string-length($INSMK)>0">
					<xsl:value-of select="5"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:value-of select="$ResultLot+$ResultSerial+$ResultInspection"/>
	</xsl:template>
	<!-- ___________________________________________________________ julian_date ___________________________________________________________-->
	<!-- converts from Apriso time/date to Julian format date YYYYMMDD -->
	<xsl:template match="*">
		<xsl:for-each select=".">
			<xsl:call-template name="julian_date">
				<xsl:with-param name="apriso_date_in" select="."/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="julian_date">
		<xsl:param name="apriso_date_in" select="."/>
		<xsl:variable name="time1" select="substring($apriso_date_in,1,10)"/>
		<xsl:value-of select="translate($time1,'-','')"/>
	</xsl:template>
	<!-- ___________________________________________________________ getplant ___________________________________________________________-->
	<!-- converts from Apriso time/date to Julian format date YYYYMMDD -->
	<xsl:template match="*">
		<xsl:for-each select=".">
			<xsl:call-template name="GetPlant">
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="GetPlant">		
		<xsl:value-of select="//PLANT[1]"/>
	</xsl:template>
	<!-- ___________________________________________________________ GetFirstAvailable ___________________________________________________________-->
	<!-- converts from Apriso time/date to Julian format date YYYYMMDD -->
	<xsl:template match="*">
		<xsl:for-each select=".">
			<xsl:call-template name="GetFirstAvailable">
				<xsl:with-param name="Value1" select="."/>
				<xsl:with-param name="Value2" select="."/>
				<xsl:with-param name="Value3" select="."/>
				<xsl:with-param name="Value4" select="."/>
				<xsl:with-param name="Value5" select="."/>
				<xsl:with-param name="Value6" select="."/>
				<xsl:with-param name="Value7" select="."/>
				<xsl:with-param name="Value8" select="."/>
				<xsl:with-param name="Value9" select="."/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="GetFirstAvailable">
		<xsl:param name="Value1" select="."/>
		<xsl:param name="Value2" select="."/>
		<xsl:param name="Value3" select="."/>
		<xsl:param name="Value4" select="."/>
		<xsl:param name="Value5" select="."/>
		<xsl:param name="Value6" select="."/>
		<xsl:param name="Value7" select="."/>
		<xsl:param name="Value8" select="."/>
		<xsl:param name="Value9" select="."/>
		<xsl:variable name="FirstValue">
			<xsl:choose>
				<xsl:when test="string-length($Value1)>0">
					<xsl:value-of select="$Value1"/>
				</xsl:when>
				<xsl:when test="string-length($Value2)>0">
					<xsl:value-of select="$Value2"/>
				</xsl:when>
				<xsl:when test="string-length($Value3)>0">
					<xsl:value-of select="$Value3"/>
				</xsl:when>
				<xsl:when test="string-length($Value4)>0">
					<xsl:value-of select="$Value4"/>
				</xsl:when>
				<xsl:when test="string-length($Value5)>0">
					<xsl:value-of select="$Value5"/>
				</xsl:when>
				<xsl:when test="string-length($Value6)>0">
					<xsl:value-of select="$Value6"/>
				</xsl:when>
				<xsl:when test="string-length($Value7)>0">
					<xsl:value-of select="$Value7"/>
				</xsl:when>
				<xsl:when test="string-length($Value8)>0">
					<xsl:value-of select="$Value8"/>
				</xsl:when>
				<xsl:when test="string-length($Value9)>0">
					<xsl:value-of select="$Value9"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:value-of select="$FirstValue"/>
	</xsl:template>
	<!-- ___________________________________________________________ apriso_time ___________________________________________________________-->
	<!-- convert date YYYYMMDD and time HHMMSS to Apriso format YYYY-MM-DDThh:mm:ss -->
	<xsl:template match="*">
		<xsl:for-each select=".">
			<xsl:call-template name="apriso_time">
				<xsl:with-param name="YYYYMMDD" select="."/>
				<xsl:with-param name="HHMMSS" select="."/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="apriso_time">
		<xsl:param name="YYYYMMDD" select="."/>
		<xsl:param name="HHMMSS" select="."/>
		<xsl:variable name="year" select="substring($YYYYMMDD,1,4)"/>
		<xsl:variable name="month" select="substring($YYYYMMDD,5,2)"/>
		<xsl:variable name="day" select="substring($YYYYMMDD,7,2)"/>
		<xsl:variable name="ret_time">
			<xsl:choose>
				<xsl:when test="$HHMMSS">
					<xsl:variable name="hh" select="substring($HHMMSS,1,2)"/>
					<xsl:variable name="mm" select="substring($HHMMSS,3,2)"/>
					<xsl:variable name="ss" select="substring($HHMMSS,5,2)"/>
					<xsl:variable name="hh1">
						<xsl:choose>
							<xsl:when test="$hh=24">
								<xsl:value-of select="substring('0000',1,2)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$hh"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="ret_time1" select="concat($hh1,':')"/>
					<xsl:variable name="ret_time2" select="concat($ret_time1,$mm)"/>
					<xsl:variable name="ret_time3" select="concat($ret_time2,':')"/>
					<xsl:variable name="ret_time4" select="concat($ret_time3,$ss)"/>
					<xsl:value-of select="$ret_time4"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'00:00:00'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="ret_date1" select="concat($year,'-')"/>
		<xsl:variable name="ret_date2" select="concat($ret_date1,$month)"/>
		<xsl:variable name="ret_date3" select="concat($ret_date2,'-')"/>
		<xsl:variable name="ret_date4" select="concat($ret_date3,$day)"/>
		<xsl:variable name="ret_date5" select="concat($ret_date4,'T')"/>
		<xsl:variable name="ret_date6" select="concat($ret_date5,$ret_time)"/>
		<xsl:value-of select="$ret_date6"/>
	</xsl:template>
	<!-- ___________________________________________________________ RetreiveUnformatedTime ___________________________________________________________-->
	<!-- convert ISO date time  to HHMMSS  -->
	<xsl:template match="*">
		<xsl:for-each select=".">
			<xsl:call-template name="RetreiveUnformatedTime">
				<xsl:with-param name="DateValue" select="."/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="RetreiveUnformatedTime">
		<xsl:param name="DateValue" select="."/>
		<xsl:variable name="UnformattedDateTime" select="translate($DateValue,'-','')"/>
		<xsl:variable name="UnformattedDateTime1" select="translate($UnformattedDateTime,'T','')"/>
		<xsl:variable name="UnformattedDateTime2" select="translate($UnformattedDateTime1,':','')"/>
		<xsl:variable name="UnformattedTime" select="substring($UnformattedDateTime2,9,6)"/>
		<xsl:value-of select="$UnformattedTime"/>
	</xsl:template>
	<!-- ___________________________________________________________ RetreiveUnformatedDate ___________________________________________________________-->
	<!-- convert ISO date time to YYYYMMDD -->
	<xsl:template match="*">
		<xsl:for-each select=".">
			<xsl:call-template name="RetreiveUnformatedDate">
				<xsl:with-param name="DateValue" select="."/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="RetreiveUnformatedDate">
		<xsl:param name="DateValue" select="."/>
		<xsl:variable name="UnformattedDateTime" select="translate($DateValue,'-','')"/>
		<xsl:variable name="UnformattedDate" select="substring($UnformattedDateTime,1,8)"/>
		<xsl:value-of select="$UnformattedDate"/>
	</xsl:template>
	<!-- ___________________________________________________________ LeadingZeros18 ___________________________________________________________-->
	<xsl:template match="*">
		<xsl:for-each select=".">
			<xsl:call-template name="LeadingZeros18">
				<xsl:with-param name="NumberWithoutZeros" select="."/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="LeadingZeros18">
		<xsl:param name="NumberWithoutZeros" select="."/>
		<xsl:choose>
			<xsl:when test="number($NumberWithoutZeros)=number($NumberWithoutZeros)">
				<xsl:variable name="ZeroString" select="'000000000000000000'"/>
				<xsl:variable name="PadLength" select="18 - string-length($NumberWithoutZeros)"/>
				<xsl:variable name="PadString" select="substring($ZeroString,1,$PadLength)"/>
				<xsl:value-of select="concat($PadString,$NumberWithoutZeros)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$NumberWithoutZeros"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- ___________________________________________________________ ExtractFlexNetOperation ___________________________________________________________-->
	<!--  -->
	<xsl:template match="*">
		<xsl:for-each select=".">
			<xsl:call-template name="ExtractFlexNetOperation">
				<xsl:with-param name="OprSequenceNo" select="."/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="ExtractFlexNetOperation">
		<xsl:param name="OprSequenceNo" select="."/>
		<xsl:choose>
			<xsl:when test="contains($OprSequenceNo,'@')='true'">
				<xsl:value-of select="substring-before($OprSequenceNo,'@')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$OprSequenceNo"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- ___________________________________________________________ LeadingZeros12___________________________________________________________-->
	<xsl:template match="*">
		<xsl:for-each select=".">
			<xsl:call-template name="LeadingZeros12">
				<xsl:with-param name="NumberWithoutZeros" select="."/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="LeadingZeros12">
		<xsl:param name="NumberWithoutZeros" select="."/>
		<xsl:choose>
			<xsl:when test="number($NumberWithoutZeros)=number($NumberWithoutZeros)">
				<xsl:variable name="ZeroString" select="'000000000000'"/>
				<xsl:variable name="PadLength" select="12 - string-length($NumberWithoutZeros)"/>
				<xsl:variable name="PadString" select="substring($ZeroString,1,$PadLength)"/>
				<xsl:value-of select="concat($PadString,$NumberWithoutZeros)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$NumberWithoutZeros"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- ___________________________________________________________ LeadingZeros10___________________________________________________________-->
	<xsl:template match="*">
		<xsl:for-each select=".">
			<xsl:call-template name="LeadingZeros10">
				<xsl:with-param name="NumberWithoutZeros" select="."/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="LeadingZeros10">
		<xsl:param name="NumberWithoutZeros" select="."/>
		<xsl:choose>
			<xsl:when test="number($NumberWithoutZeros)=number($NumberWithoutZeros)">
				<xsl:variable name="ZeroString" select="'0000000000'"/>
				<xsl:variable name="PadLength" select="10 - string-length($NumberWithoutZeros)"/>
				<xsl:variable name="PadString" select="substring($ZeroString,1,$PadLength)"/>
				<xsl:value-of select="concat($PadString,$NumberWithoutZeros)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$NumberWithoutZeros"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- ___________________________________________________________ LeadingZeros8___________________________________________________________-->
	<xsl:template match="*">
		<xsl:for-each select=".">
			<xsl:call-template name="LeadingZeros8">
				<xsl:with-param name="NumberWithoutZeros" select="."/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="LeadingZeros8">
		<xsl:param name="NumberWithoutZeros" select="."/>
		<xsl:choose>
			<xsl:when test="number($NumberWithoutZeros)=number($NumberWithoutZeros)">
				<xsl:variable name="ZeroString" select="'00000000'"/>
				<xsl:variable name="PadLength" select="8 - string-length($NumberWithoutZeros)"/>
				<xsl:variable name="PadString" select="substring($ZeroString,1,$PadLength)"/>
				<xsl:value-of select="concat($PadString,$NumberWithoutZeros)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$NumberWithoutZeros"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- ___________________________________________________________ LengthGreaterThanZero _______________________________________________________-->
	<xsl:template match="*">
		<xsl:for-each select=".">
			<xsl:call-template name="LengthGreaterThanZero">
				<xsl:with-param name="Value" select="."/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="LengthGreaterThanZero">
		<xsl:param name="Value" select="."/>
		<xsl:choose>
			<xsl:when test="string-length($Value) > 0">
				<xsl:value-of select="boolean(1)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="boolean(0)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- ___________________________________________________________ StripLeadingZeros ___________________________________________________________-->
	<xsl:template match="*">
		<xsl:for-each select=".">
			<xsl:call-template name="StripLeadingZeros">
				<xsl:with-param name="NumberWithZeros" select="."/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="StripLeadingZeros">
		<xsl:param name="NumberWithZeros" select="."/>
		<xsl:choose>
			<xsl:when test="number($NumberWithZeros)=number($NumberWithZeros)">
				<xsl:value-of select="number($NumberWithZeros)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$NumberWithZeros"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- ____________________________________________________ FormatNumber_3DecimalPoint ___________________________________________________-->
	<xsl:template match="*">
		<xsl:for-each select=".">
			<xsl:call-template name="FormatNumber_3DecimalPoint">
				<xsl:with-param name="Value" select="."/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="FormatNumber_3DecimalPoint">
		<xsl:param name="Value" select="."/>
		<xsl:choose>
			<xsl:when test="number($Value)=number($Value)">
				<xsl:value-of select="format-number($Value,'0.000')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$Value"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- ___________________________________________________________ PadString ___________________________________________________________-->
	<xsl:template match="*">
		<xsl:for-each select=".">
			<xsl:call-template name="PadString">
				<xsl:with-param name="StringIn" select="."/>
				<xsl:with-param name="StringLength" select="."/>
				<xsl:with-param name="Char" select="."/>
				<xsl:with-param name="PadLeftRight" select="."/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="PadString">
		<xsl:param name="StringIn" select="."/>
		<xsl:param name="StringLength" select="."/>
		<xsl:param name="Char" select="."/>
		<xsl:param name="PadLeftRight" select="."/>
		<xsl:variable name="ReturnString">
			<xsl:choose>
				<xsl:when test="$StringLength > string-length($StringIn)">
					<!--xsl:variable name="StringIn2" select="format-number($StringIn,'#')"/-->
					<xsl:variable name="ZeroString" select="'0000000000000000000000000000000000000000000000000000000000000000000000000000000'"/>
					<xsl:variable name="PadLength" select="$StringLength - string-length($StringIn)"/>
					<xsl:variable name="PadString" select="substring($ZeroString,1,$PadLength)"/>
					<xsl:variable name="PadString2" select="translate($PadString,'0',$Char)"/>
					<xsl:variable name="RET1">
						<xsl:choose>
							<xsl:when test="$PadLeftRight = 'R'">
								<xsl:value-of select="concat($StringIn,$PadString2)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($PadString2,$StringIn)"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<xsl:value-of select="$RET1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="substring($StringIn,1,$StringLength)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:value-of select="$ReturnString"/>
	</xsl:template>
	<!-- ___________________________________________________________ OrderID ___________________________________________________________-->
	<xsl:template match="*">
		<xsl:for-each select=".">
			<xsl:call-template name="OrderID">
				<xsl:with-param name="WipOrderType" select="."/>
				<xsl:with-param name="WipOrderNumber" select="."/>
				<xsl:with-param name="ParentWipOrderNumber" select="."/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="OrderID">
		<xsl:param name="WipOrderType" select="."/>
		<xsl:param name="WipOrderNumber" select="."/>
		<xsl:param name="ParentWipOrderNumber" select="."/>
		<xsl:variable name="OrderID">
			<xsl:choose>
				<xsl:when test="$WipOrderType = 1">
					<xsl:value-of select="$WipOrderNumber"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$ParentWipOrderNumber"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="OrderID2">
			<xsl:choose>
				<xsl:when test="($OrderID = 0) or ($OrderID = '')">
					<xsl:value-of select="''"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="PadString">
						<xsl:with-param name="StringIn" select="$OrderID"/>
						<xsl:with-param name="StringLength" select="12"/>
						<xsl:with-param name="Char" select="'0'"/>
						<xsl:with-param name="PadLeftRight" select="'L'"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:value-of select="$OrderID2"/>
	</xsl:template>
	<!-- ___________________________________________________________ CompareChooser ___________________________________________________________-->
	<!-- 
	<xsl:template match="*">
		<xsl:for-each select=".">
			<xsl:call-template name="If-Equal-Then">
				<xsl:with-param name="InputToCompare" select="."/>
				<xsl:with-param name="MatchThis" select="."/>
				<xsl:with-param name="IsMatch" select="."/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	-->
	<xsl:template match="*">
		<xsl:for-each select=".">
			<xsl:call-template name="CompareChooser">
				<xsl:with-param name="InputToCompare" select="."/>
				<xsl:with-param name="MatchThis" select="."/>
				<xsl:with-param name="IsMatch" select="."/>
				<xsl:with-param name="NoMatch" select="."/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="CompareChooser">
		<xsl:param name="InputToCompare" select="."/>
		<xsl:param name="MatchThis" select="."/>
		<xsl:param name="IsMatch" select="."/>
		<xsl:param name="NoMatch" select="."/>
		<xsl:variable name="ChosenOne">
			<xsl:choose>
				<xsl:when test="$InputToCompare = $MatchThis">
					<xsl:value-of select="$IsMatch"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$NoMatch"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:value-of select="$ChosenOne"/>
	</xsl:template>
	<!--__________________________________________________ SAPProductInventoryTypeConversion  _________________________________________________________-->
	<xsl:template match="*">
		<xsl:for-each select=".">
			<xsl:call-template name="SAPProductInventoryTypeConversion">
				<xsl:with-param name="MaterialType" select="."/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="SAPProductInventoryTypeConversion">
		<xsl:param name="MaterialType" select="."/>
		<xsl:variable name="ProductInventoryType">
			<xsl:choose>
				<xsl:when test="$MaterialType = 'CONT'">
					<xsl:value-of select="1"/>
				</xsl:when>
				<xsl:when test="$MaterialType = 'LEIH'">1</xsl:when>
				<xsl:when test="$MaterialType = 'VERP'">2</xsl:when>
				<xsl:when test="$MaterialType = 'ERSA'">5</xsl:when>
				<xsl:when test="$MaterialType = 'IBAU'">5</xsl:when>
				<xsl:when test="$MaterialType = 'NLAG'">6</xsl:when>
				<xsl:when test="$MaterialType = 'UNBW'">6</xsl:when>
				<xsl:when test="$MaterialType = 'FERT'">8</xsl:when>
				<xsl:when test="$MaterialType = 'FGTR'">8</xsl:when>
				<xsl:when test="$MaterialType = 'FHMI'">8</xsl:when>
				<xsl:when test="$MaterialType = 'FOOD'">8</xsl:when>
				<xsl:when test="$MaterialType = 'FRIP'">8</xsl:when>
				<xsl:when test="$MaterialType = 'HALB'">8</xsl:when>
				<xsl:when test="$MaterialType = 'HAWA'">8</xsl:when>
				<xsl:when test="$MaterialType = 'HERB'">8</xsl:when>
				<xsl:when test="$MaterialType = 'INTR'">8</xsl:when>
				<xsl:when test="$MaterialType = 'KMAT'">8</xsl:when>
				<xsl:when test="$MaterialType = 'MODE'">8</xsl:when>
				<xsl:when test="$MaterialType = 'NOF1'">8</xsl:when>
				<xsl:when test="$MaterialType = 'PROC'">8</xsl:when>
				<xsl:when test="$MaterialType = 'ROH'">8</xsl:when>
				<xsl:when test="$MaterialType = 'PIPE'">9</xsl:when>
				<xsl:otherwise>6</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:value-of select="$ProductInventoryType"/>
	</xsl:template>
	<!--__________________________________________________ SAPLanguageIDConversion  _________________________________________________________-->
	<xsl:template match="*">
		<xsl:for-each select=".">
			<xsl:call-template name="SAPLanguageIDConversion">
				<xsl:with-param name="SPRAS_ISO" select="."/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="SAPLanguageIDConversion">
		<xsl:param name="SPRAS_ISO" select="."/>
		<xsl:variable name="LanguageID">
			<xsl:choose>
				<xsl:when test="$SPRAS_ISO = 'E'  ">1033</xsl:when>
				<xsl:when test="$SPRAS_ISO = 'EN' ">1033</xsl:when>
				<xsl:when test="$SPRAS_ISO = 'AR' ">1025</xsl:when>
				<xsl:when test="$SPRAS_ISO = 'ZH' ">2052</xsl:when>
				<xsl:when test="$SPRAS_ISO = 'DE' ">1031</xsl:when>
				<xsl:when test="$SPRAS_ISO = 'FR' ">1036</xsl:when>
				<xsl:when test="$SPRAS_ISO = 'IT' ">1040</xsl:when>
				<xsl:when test="$SPRAS_ISO = 'JA' ">1041</xsl:when>
				<xsl:when test="$SPRAS_ISO = 'KO' ">1042</xsl:when>
				<xsl:when test="$SPRAS_ISO = 'PL' ">1045</xsl:when>
				<xsl:when test="$SPRAS_ISO = 'PT' ">1046</xsl:when>
				<xsl:when test="$SPRAS_ISO = 'RU' ">1049</xsl:when>
				<xsl:when test="$SPRAS_ISO = 'TH' ">1054</xsl:when>
				<xsl:when test="$SPRAS_ISO = 'ES' ">2058</xsl:when>
				<xsl:when test="$SPRAS_ISO = '1'  ">2052</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:value-of select="$LanguageID"/>
	</xsl:template>
	<!-- ___________________________________________________________ First20Char  ___________________________________________________________-->
	<xsl:template match="*">
		<xsl:for-each select=".">
			<xsl:call-template name="First20Char">
				<xsl:with-param name="StringValue" select="."/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="First20Char">
		<xsl:param name="StringValue" select="."/>
		<xsl:value-of select="substring($StringValue,1,20)"/>
	</xsl:template>
	<!-- _________________________________________________________ ReplaceDotWithComma
____________________________________________________________-->
	<xsl:template match="*">
		<xsl:for-each select=".">
			<xsl:call-template name="ReplaceDotWithComma">
				<xsl:with-param name="Value" select="."/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="ReplaceDotWithComma">
		<xsl:param name="Value" select="."/>
		<xsl:value-of select="translate($Value,'.',',')"/>
	</xsl:template>
	<!-- _________________________________________________________ ReplaceCommaWithDot
____________________________________________________________-->
	<xsl:template match="*">
		<xsl:for-each select=".">
			<xsl:call-template name="ReplaceCommaWithDot">
				<xsl:with-param name="Value" select="."/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="ReplaceCommaWithDot">
		<xsl:param name="Value" select="."/>
		<xsl:value-of select="translate($Value,',','.')"/>
	</xsl:template>
	<!-- _________________________________________________________ BuildExplosionJobParameters ________________________________________________________-->
	<xsl:template match="*">
		<xsl:for-each select=".">
			<xsl:call-template name="BuildExplosionJobParameters">
				<xsl:with-param name="WipOrderNo" select="."/>
				<xsl:with-param name="WipOrderType" select="."/>
				<xsl:with-param name="ProcessID" select="."/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="BuildExplosionJobParameters">
		<xsl:param name="WipOrderNo" select="."/>
		<xsl:param name="WipOrderType" select="."/>
		<xsl:param name="ProcessID" select="."/>
		<xsl:variable name="ParameterXML" select="concat('&lt;?xml version=&quot;1.0&quot; encoding=&quot;utf-8&quot; ?&gt;&lt;ExplosionJobParameters xmlns:xsd=&quot;http://www.w3.org/2001/XMLSchema&quot; xmlns:xsi=&quot;http://www.w3.org/2001/XMLSchema-instance&quot;&gt;' , '&lt;WipOrderNo&gt;', $WipOrderNo, '&lt;/WipOrderNo&gt;', '&lt;WipOrderType&gt;', $WipOrderType,'&lt;/WipOrderType&gt;','&lt;ProcessID&gt;',$ProcessID,'&lt;/ProcessID&gt;', '&lt;/ExplosionJobParameters&gt;')"/>
		<!--
		<xsl:variable name="ParameterXML" select="concat('&gt;![CDATA[', ']]&lt;')"/>
		<xsl:variable name="WipOrderNoResult" select="concat('WipOrderNo', $WipOrderNo)"/>
		<xsl:variable name="content" select="$WipOrderNoResult+$WipOrderTypeResultl+$ProcessIDResult"/>
		<xsl:variable name="content" select="$WipOrderNoResult+$WipOrderTypeResultl+$ProcessIDResult"/>
		-->
		<xsl:value-of select="$ParameterXML"/>
	</xsl:template>
	<!-- _________________________________________________________ SplitListOfDataTypes ________________________________________________________-->
	<!--
	<xsl:template match="*">
		<xsl:for-each select=".">
			<xsl:call-template name="tokenize">
				<xsl:with-param name="inputString" select="."/>
				<xsl:with-param name="delimiters" select="."/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="tokenize">
		<xsl:param name="inputString" select="."/>
		<xsl:param name="delimiters" select="."/>
		<xsl:variable name="InputLength" select="string-length($inputString)-2"/>
		<xsl:variable name="newinput">
			<xsl:choose>
				<xsl:when test="starts-with($inputString, '{')">
						<xsl:value-of select="substring($inputString, 2, 19)"/>	
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$inputString"/>	
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="not($newinput)"/>
			<xsl:when test="not($delimiters)">
				<xsl:call-template name="_tokenize-characters">
					<xsl:with-param name="inputString" select="$newinput"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="_tokenize-delimiters">
					<xsl:with-param name="inputString" select="$newinput"/>
					<xsl:with-param name="delimiters" select="$delimiters"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="_tokenize-characters">
		<xsl:param name="inputString"/>
		<xsl:if test="$inputString">
			<xsl:variable name="Result">
				<xsl:value-of select="substring($inputString, 1, 1)"/>
			</xsl:variable>
			<xsl:call-template name="_tokenize-characters">
				<xsl:with-param name="inputString" select="substring($inputString, 2)"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<xsl:template name="_tokenize-delimiters">
		<xsl:param name="inputString"/>
		<xsl:param name="delimiters"/>
		<xsl:variable name="delimiter" select="substring($delimiters, 1, 1)"/>
		<xsl:choose>
			<xsl:when test="not($delimiter)">
				<xsl:variable name="Result">
					<xsl:value-of select="concat($Result,'&lt;token&gt;',$inputString,'&lt;/token&gt;')"/>
				</xsl:variable>
			</xsl:when>
			<xsl:when test="contains($inputString, $delimiter)">
				<xsl:if test="not(starts-with($inputString, $delimiter))">
					<xsl:call-template name="_tokenize-delimiters">
						<xsl:with-param name="inputString" select="substring-before($inputString, $delimiter)"/>
						<xsl:with-param name="delimiters" select="substring($delimiters, 2)"/>
					</xsl:call-template>
				</xsl:if>
				<xsl:call-template name="_tokenize-delimiters">
					<xsl:with-param name="inputString" select="substring-after($inputString, $delimiter)"/>
					<xsl:with-param name="delimiters" select="$delimiters"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="_tokenize-delimiters">
					<xsl:with-param name="inputString" select="$inputString"/>
					<xsl:with-param name="delimiters" select="substring($delimiters, 2)"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
-->
<!-- _________________________________________________________ CategoryTypeTranslation ______________________________________________________-->
	<xsl:template match="*">
		<xsl:for-each select=".">
			<xsl:call-template name="CategoryTypeTranslation">
				<xsl:with-param name="SAPCategoryType" select="."/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="CategoryTypeTranslation">
		<xsl:param name="SAPCategoryType"/>
		<xsl:variable name="Vvar3_INPUT" select="$SAPCategoryType"/>
		<xsl:variable name="Vvar4_CONST" select="'A'"/>
		<xsl:variable name="Vvar5_CONST" select="'10'"/>
		<xsl:variable name="Vvar6_RESULTOF_translate" select="translate($Vvar3_INPUT, $Vvar4_CONST, $Vvar5_CONST)"/>
		<xsl:variable name="Vvar7_CONST" select="'B'"/>
		<xsl:variable name="Vvar8_CONST" select="'11'"/>
		<xsl:variable name="Vvar9_RESULTOF_translate" select="translate($Vvar6_RESULTOF_translate, $Vvar7_CONST, $Vvar8_CONST)"/>
		<xsl:variable name="Vvar10_CONST" select="'C'"/>
		<xsl:variable name="Vvar11_CONST" select="'13'"/>
		<xsl:variable name="Vvar12_RESULTOF_translate" select="translate($Vvar9_RESULTOF_translate, $Vvar10_CONST, $Vvar11_CONST)"/>
		<xsl:variable name="Vvar13_CONST" select="'D'"/>
		<xsl:variable name="Vvar14_CONST" select="'14'"/>
		<xsl:variable name="Vvar15_RESULTOF_translate" select="translate($Vvar12_RESULTOF_translate, $Vvar13_CONST, $Vvar14_CONST)"/>
		<xsl:variable name="Vvar16_CONST" select="'E'"/>
		<xsl:variable name="Vvar17_CONST" select="'15'"/>
		<xsl:variable name="Vvar18_RESULTOF_translate" select="translate($Vvar15_RESULTOF_translate, $Vvar16_CONST, $Vvar17_CONST)"/>
		<xsl:variable name="Vvar19_CONST" select="'Q'"/>
		<xsl:variable name="Vvar20_CONST" select="'16'"/>
		<xsl:variable name="Vvar21_RESULTOF_translate" select="translate($Vvar18_RESULTOF_translate, $Vvar19_CONST, $Vvar20_CONST)"/>
		<xsl:variable name="Vvar22_CONST" select="'100'"/>
		<xsl:variable name="Vvar23_RESULTOF_add" select="$Vvar21_RESULTOF_translate + $Vvar22_CONST"/>
		<xsl:value-of select="$Vvar23_RESULTOF_add"/>
	</xsl:template>
<!-- _________________________________________________________ ConvertExponent2Decimal 9.5______________________________________________________-->
	<xsl:template match="*">
		<xsl:for-each select=".">
			<xsl:call-template name="ConvertExponent2Decimal">
				<xsl:with-param name="Exponent" select="."/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="ConvertExponent2Decimal">
		<xsl:param name="Exponent"/>
		<xsl:variable name="LengthGreaterThanZeroResult">
			<xsl:call-template name="LengthGreaterThanZero">
				<xsl:with-param name="Value" select="$Exponent"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="ConditionResult">
			<xsl:choose>
				<xsl:when test="string($LengthGreaterThanZeroResult)='true'">
					<xsl:variable name="DivisionResult" select="$Exponent div '1'"/>
					<xsl:value-of select="$DivisionResult"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$Exponent"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:value-of select="$ConditionResult"/>
	</xsl:template>
</xsl:stylesheet>
