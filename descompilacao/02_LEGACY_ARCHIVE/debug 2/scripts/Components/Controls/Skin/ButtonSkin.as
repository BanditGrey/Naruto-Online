package Components.Controls.Skin
{
   import Components.Controls.*;
   import Components.Controls.Managers.*;
   import Components.Controls.ModeStyles.*;
   import Components.Controls.Support.*;
   import flash.display.*;
   import flash.geom.*;
   
   public class ButtonSkin extends ActionDrawSkin
   {
      
      private var tar:Button;
      
      private var mot:MotionSkinControl;
      
      private var shape:Shape;
      
      private var styleSet:Object;
      
      public function ButtonSkin()
      {
         super();
         this.shape = new Shape();
      }
      
      override public function init(param1:UIComponent, param2:Object) : void
      {
         this.styleSet = param2;
         this.tar = param1 as Button;
         param1.addChildAt(this.shape,0);
         this.mot = new MotionSkinControl(this.tar,this.shape);
      }
      
      public function get skinDisplayObject() : DisplayObject
      {
         return this.shape;
      }
      
      override public function hideOutState() : void
      {
         super.hideOutState();
         this.shape.alpha = 0;
         this.mot.setOutViewHide(true);
      }
      
      override public function reDraw() : void
      {
         var _loc3_:Array = null;
         this.shape.graphics.clear();
         var _loc1_:Array = [SkinThemeColor.top,SkinThemeColor.upperMiddle,SkinThemeColor.lowerMiddle,SkinThemeColor.bottom];
         var _loc2_:Array = [1,1,1,1];
         if(ThemesSet.GradientMode == 1)
         {
            _loc3_ = [0,127,128,255];
         }
         if(ThemesSet.GradientMode == 2)
         {
            _loc3_ = [0,50,205,255];
         }
         var _loc4_:Matrix = new Matrix();
         var _loc5_:Number = this.tar.compoWidth - 0;
         var _loc6_:Number = this.tar.compoHeight - 0;
         _loc4_.createGradientBox(_loc5_,_loc6_,90 * Math.PI / 180);
         this.shape.graphics.lineStyle(1,SkinThemeColor.border,1,true,LineScaleMode.NORMAL,CapsStyle.ROUND,JointStyle.ROUND,3);
         this.shape.graphics.beginGradientFill(GradientType.LINEAR,_loc1_,_loc2_,_loc3_,_loc4_);
         var _loc7_:Number = Number(this.styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_WIDTH]);
         var _loc8_:Number = Number(this.styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_HEIGHT]);
         var _loc9_:Number = Number(this.styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_BOTTOM_WIDTH]);
         var _loc10_:Number = Number(this.styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_BOTTOM_HEIGHT]);
         RoundRectAdvancedDraw.drawAdvancedRoundRect(this.shape.graphics,0,0,_loc5_,_loc6_,_loc7_,_loc8_,_loc7_,_loc8_,_loc7_,_loc8_,_loc9_,_loc10_,_loc9_,_loc10_);
         this.shape.cacheAsBitmap = true;
         this.shape.filters = DefaultStyle.filters;
      }
   }
}

