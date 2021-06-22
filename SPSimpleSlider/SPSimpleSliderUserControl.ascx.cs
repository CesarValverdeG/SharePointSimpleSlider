using Microsoft.SharePoint.Administration;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

namespace SharePointSimpleSlider.SPSimpleSlider
{
    public partial class SPSimpleSliderUserControl : UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            bool PropsNotSet = false;

            SPSimpleSlider WebPartRef = (SPSimpleSlider)Parent;

            // check our web properties
            if (WebPartRef != null)
            {
                if (string.IsNullOrEmpty(WebPartRef.ImageLibraryTitle))
                    PropsNotSet = true;
            }
            else
            {
                PropsNotSet = true;
            }


            if (PropsNotSet)
            {
                InfoMessage.Text = "Image Library Title property is not set.";
                return;
            }

            HFImageLibraryTitle.Value = "" + WebPartRef.ImageLibraryTitle;
            HFAutoplay.Value = "" + WebPartRef.Autoplay;
            HFSlidesToScroll.Value = "" + WebPartRef.SlidesToScroll;
            HFSlidesToShow.Value = "" + WebPartRef.SlidesToShow;
            HFAutoplaySpeed.Value = "" + WebPartRef.AutoplaySpeed;
            HFSlideWidth.Value = "" + WebPartRef.SlideWidth;
            HFRandom.Value = "" + Guid.NewGuid().ToString();
        }

        #region LogError
        public void LogError(string error)
        {
            try
            {
                SPDiagnosticsService diagSvc = SPDiagnosticsService.Local;
                diagSvc.WriteTrace(0, new SPDiagnosticsCategory("SPSimpleSlider", TraceSeverity.Monitorable, EventSeverity.Error), TraceSeverity.Monitorable, "debug:  {0}", new object[] { error });
            }
            catch { }
        }
        #endregion
    }
}
