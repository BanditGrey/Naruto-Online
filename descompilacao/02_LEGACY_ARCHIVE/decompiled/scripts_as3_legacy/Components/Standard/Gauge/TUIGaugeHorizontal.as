package Components.Standard.Gauge
{
   import ghostcat.util.easing.Cubic;
   import ghostcat.util.easing.TweenUtil;
   
   public class TUIGaugeHorizontal extends TUIGauge
   {
      
      public function TUIGaugeHorizontal()
      {
         super();
      }
      
      override protected function RenderingPerform_Gauge() : void
      {
         var _loc1_:int = 0;
         if(FModeGauge == MODE_PROGRESS_PERCENTAGE)
         {
            if(FIsScale)
            {
               if(FUIProgressBar.scaleX > FRatio)
               {
                  FUIProgressBar.scaleX = FRatio;
               }
               TweenUtil.removeTween(FUIProgressBar,false);
               TweenUtil.to(FUIProgressBar,300,{
                  "scaleX":FRatio,
                  "ease":Cubic.easeIn
               });
            }
            else
            {
               _loc1_ = FUIProgressBar.width * FRatio;
               FUIProgressBar.x = 0 - FUIProgressBar.width + _loc1_;
            }
         }
         super.RenderingPerform_Gauge();
      }
   }
}

