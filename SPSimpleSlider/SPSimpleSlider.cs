using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;
using System;
using System.ComponentModel;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

namespace SharePointSimpleSlider.SPSimpleSlider
{
    [ToolboxItemAttribute(false)]
    public class SPSimpleSlider : WebPart
    {
        // Visual Studio might automatically update this path when you change the Visual Web Part project item.
        private const string _ascxPath = @"~/_CONTROLTEMPLATES/15/SharePointSimpleSlider/SPSimpleSlider/SPSimpleSliderUserControl.ascx";

        protected override void CreateChildControls()
        {
            Control control = Page.LoadControl(_ascxPath);
            Controls.Add(control);
        }

        [WebBrowsable(true),
        Category("SPSimpleSlider Properties"),
        Personalizable(PersonalizationScope.Shared),
        WebDisplayName("Image Library Title"),
        WebDescription("")]
        public string ImageLibraryTitle
        {
            get;
            set;
        }

        [WebBrowsable(true),
        Category("SPSimpleSlider Properties"),
        Personalizable(PersonalizationScope.Shared),
        WebDisplayName("Slides To Show"),
        WebDescription("Number of slides to be displayed")]
        public int SlidesToShow
        {
            get;
            set;
        }

        [WebBrowsable(true),
        Category("SPSimpleSlider Properties"),
        Personalizable(PersonalizationScope.Shared),
        WebDisplayName("Autoplay Speed"),
        WebDescription("Time in miliseconds")]
        public int AutoplaySpeed
        {
            get;
            set;
        }

        [WebBrowsable(true),
        Category("SPSimpleSlider Properties"),
        Personalizable(PersonalizationScope.Shared),
        WebDisplayName("Slides To Scroll"),
        WebDescription("If you don't know just set it to 1")]
        public int SlidesToScroll
        {
            get;
            set;
        }

        [WebBrowsable(true),
        Category("SPSimpleSlider Properties"),
        Personalizable(PersonalizationScope.Shared),
        WebDisplayName("Slide Width"),
        WebDescription("")]
        public int SlideWidth
        {
            get;
            set;
        }

        [WebBrowsable(true),
        Category("SPSimpleSlider Properties"),
        Personalizable(PersonalizationScope.Shared),
        WebDisplayName("Autoplay"),
        WebDescription("")]
        public bool Autoplay
        {
            get;
            set;
        }
    }
}
