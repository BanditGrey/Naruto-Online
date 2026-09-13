package Components.SelectBox
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TSelectBoxSingle extends TSelectBox
   {
      
      protected var FCurrentSelectIndex:int;
      
      public function TSelectBoxSingle()
      {
         super();
         this.FCurrentSelectIndex = -1;
      }
      
      override protected function OnTaskClick(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = param1.currentTarget as MovieClip;
         _loc4_ = _loc2_.currentFrame;
         UnselectAll();
         _loc2_.gotoAndStop(_loc4_);
         super.OnTaskClick(param1);
      }
   }
}

