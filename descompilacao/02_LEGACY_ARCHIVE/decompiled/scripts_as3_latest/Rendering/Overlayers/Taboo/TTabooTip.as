package Rendering.Overlayers.Taboo
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityCartisian;
   import Processors.Game.Lobby.Taboo.Data.TabooDataCell;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Constants.CONST_COMMON;
   
   public class TTabooTip extends TOverlayer
   {
      
      protected static const QUALITYCOLOR_INDEX:Vector.<uint> = CONST_COMMON.QUALITYCOLOR_INDEX;
      
      protected static const COLOR_Context_White:uint = 4294967295;
      
      protected static const COLOR_Context_YELLOW:uint = 4294967040;
      
      protected static const COLOR_Context_BLUE:uint = 4278228735;
      
      protected var FConFig:TabooDataCell = null;
      
      protected var TPName:TPainterTextEffect;
      
      protected var FBName:TBounds;
      
      protected var TPDesTwo:TPainterTextEffect;
      
      protected var FBDesTwo:TBounds;
      
      public function TTabooTip(param1:TUIComponent)
      {
         super(param1);
         this.TPName = ConstructPainterTextEffect(COLOR_Context_BLUE);
         this.FBName = new TBounds();
         this.TPDesTwo = ConstructPainterTextEffect(COLOR_Context_YELLOW);
         this.FBDesTwo = new TBounds();
         FMarginLeft = 15;
         FMarginTop = 15;
         FMarginRight = 15;
         FMarginBottom = 15;
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         this.FConFig = FContext as TabooDataCell;
         this.nAme();
         this.dEs();
      }
      
      protected function nAme() : void
      {
         this.BoundsAlignDown(this.FBName);
         this.TPName.Text = this.FConFig.ConfigureConfig.Name;
         this.TPName.Evaluate(this.FBName);
         BoundsContextUnion(this.FBName);
      }
      
      protected function dEs() : void
      {
         this.BoundsAlignDown(this.FBDesTwo);
         var _loc1_:String = this.FConFig.ConfigureConfig.Description;
         var _loc2_:RegExp = /%t/g;
         _loc1_ = _loc1_.replace(_loc2_,"\n");
         this.TPDesTwo.Text = _loc1_;
         this.TPDesTwo.Evaluate(this.FBDesTwo);
         BoundsContextUnion(this.FBDesTwo);
      }
      
      override public function set Context(param1:Object) : void
      {
         if(param1 != null)
         {
            if(!ContextVerificate(param1))
            {
               param1 = null;
            }
         }
         FContext = param1;
         FModified = true;
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         this.TPName.X = FBoundsRendering.X + this.FBName.X;
         this.TPName.Y = FBoundsRendering.Y + this.FBName.Y;
         this.TPDesTwo.X = FBoundsRendering.X + this.FBDesTwo.X;
         this.TPDesTwo.Y = FBoundsRendering.Y + this.FBDesTwo.Y;
      }
      
      protected function BoundsAlignDownCopy(param1:TBounds, param2:TBounds = null, param3:int = 0) : void
      {
         if(param2 == null)
         {
            param2 = FBoundsContext;
         }
         TUtilityCartisian.CoordinateSet(param1,param2.X + param2.Width,param2.Y + param3);
      }
      
      override protected function BoundsAlignDown(param1:TBounds, param2:TBounds = null, param3:int = 0) : void
      {
         if(param2 == null)
         {
            param2 = FBoundsContext;
         }
         TUtilityCartisian.CoordinateSet(param1,param2.X,param2.YEnd + param3);
      }
      
      override public function Show() : void
      {
         if(!this.visible)
         {
            this.visible = true;
         }
      }
      
      override public function Hide() : void
      {
         if(this.visible)
         {
            this.visible = false;
         }
      }
   }
}

