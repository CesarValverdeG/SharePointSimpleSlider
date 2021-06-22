<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SPSimpleSliderUserControl.ascx.cs" Inherits="SharePointSimpleSlider.SPSimpleSlider.SPSimpleSliderUserControl" %>

<asp:Literal ID="InfoMessage" runat="server" />

<!-- WebPart properties values -->
<asp:HiddenField ID="HFImageLibraryTitle" runat="server" />
<asp:HiddenField ID="HFSlidesToShow" runat="server" />
<asp:HiddenField ID="HFAutoplaySpeed" runat="server" />
<asp:HiddenField ID="HFSlidesToScroll" runat="server" />
<asp:HiddenField ID="HFAutoplay" runat="server" />
<asp:HiddenField ID="HFSlideWidth" runat="server" />
<asp:HiddenField ID="HFRandom" runat="server" />

<!-- END - WebPart properties values -->

<% if(string.IsNullOrWhiteSpace(InfoMessage.Text)) %>
<% { %>

<script type="text/javascript">

    //-- Methods -----------------------------------------------------------------------------
    var requireCSSOnce = function(url) {
        var found = false;
        for (var i = 0; i < document.styleSheets.length; i++) {
            if (document.styleSheets[i].href == url) {
                found = true;
                break;
            }
        }
        if (!found) {
            $('head').append(
                $('<link rel="stylesheet" type="text/css" href="' + url + '" />')
            );
        }
    }

    var requireJSOnce = function(url) {
        if(!$("script[src='" + url + "']").length) {
            console.log('Adding: ' + url);
            $('head').append("<script type='text/javascript' src='" + url + "'><script>"); 
        }else{
            console.log('It is already there: ' + url);
        }
    };
    //-- END - Methods -----------------------------------------------------------------------

    //--- Load require slider lib files ------------------------------------------------------
    requireCSSOnce('/Style%20Library/SlickSlider/slick/slick.css');
    requireCSSOnce('/Style%20Library/SlickSlider/slick/slick-theme.css');
    requireJSOnce('/Style%20Library/SlickSlider/slick/slick.min.js');
    //--- END - Load require slider lib files ------------------------------------------------

    //--- Properties -------------------------------------------------------------------------
    var prop_slideWidth = <%= HFSlideWidth.Value %>;
    var prop_slidesToShow = <%= HFSlidesToShow.Value %>;
    var prop_slidesToScroll = <%= HFSlidesToScroll.Value %>;
    var prop_autoplay = <%= HFAutoplay.Value.ToLowerInvariant() %>;
    var prop_autoplaySpeed = <%= HFAutoplaySpeed.Value %>;
    var prop_random = "<%= HFRandom.Value %>";
    //--- END - Properties -------------------------------------------------------------------
    
    //--- Rendering images from Image Library ------------------------------------------------
    
    var carouselImageLibraryAPI_URL = _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getByTitle('" + "<%= HFImageLibraryTitle.Value %>" + "')/items?$select=EncodedAbsUrl,Title";
    $.ajax({
        url: carouselImageLibraryAPI_URL,
        type: 'GET',
        dataType: 'json',
        headers: {
            "accept": "application/json;odata=verbose"
        },
        success: function(data) {
            $.each(data.d.results, function(i, result) {
                var imageURL = result.EncodedAbsUrl;
                $(".slideshow-container-" + prop_random).append("<div style='width:" + prop_slideWidth + "px' class='slide'><a href='#'><img style='width:100%;height: auto' src='" + imageURL + "'></a></div>");
            });

            //--- Slider setup ------------------------------------------------------------------------
            $('.slideshow-container-' + prop_random).width(prop_slideWidth);
            $('.slideshow-container-' + prop_random).slick({
                slidesToShow: prop_slidesToShow,
                slidesToScroll: prop_slidesToScroll,
                autoplay: prop_autoplay,
                autoplaySpeed: prop_autoplaySpeed,
                variableWidth: true,
                dots: true
            });

            //--- END - Slider setup ------------------------------------------------------------------

        },
        error: function ajaxError(response) {
            console.log(response.status + ' ' + response.statusText);
        }
    });
    //--- END - Rendering images from Image Library -------------------------------------------

</script>

<div class="slideshow-container-<%= HFRandom.Value %>"> 
</div>

<% } %>