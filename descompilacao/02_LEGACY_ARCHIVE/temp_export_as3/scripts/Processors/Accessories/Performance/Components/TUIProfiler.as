package Processors.Accessories.Performance.Components
{
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Resources.Constants.*;
   import flash.display.*;
   import flash.text.*;
   
   public class TUIProfiler extends TUIComponent
   {
      
      private const FORMAT_INFO:String = "Ver: %0   |\tSSD: %1   |   CSD: %2   |   Current Fps %3   |   Average Fps %4   |   Memory Used %5Mb";
      
      private var FTFMinFps:TextField;
      
      private var FTFMaxFps:TextField;
      
      private var FTFMinMem:TextField;
      
      private var FTFMaxMem:TextField;
      
      private var FTFInfo:TextField;
      
      private var FShapeBox:Shape;
      
      private var FShapeFps:Shape;
      
      private var FShapeMb:Shape;
      
      public function TUIProfiler(param1:TUIComponent)
      {
         var _loc2_:TextFormat = null;
         super(param1);
         this.FShapeFps = new Shape();
         this.FShapeMb = new Shape();
         this.FShapeBox = new Shape();
         addChild(this.FShapeBox);
         addChild(this.FShapeFps);
         addChild(this.FShapeMb);
         this.FShapeFps.x = 65;
         this.FShapeFps.y = 45;
         this.FShapeMb.x = 65;
         this.FShapeMb.y = 90;
         _loc2_ = new TextFormat(CONST_COMMON.FONT_DefaultName,CONST_COMMON.FONT_DefaultSize - 2,11184810);
         this.FTFInfo = this.ConstructTextField(this,_loc2_,0,98);
         this.FTFInfo.defaultTextFormat = new TextFormat(CONST_COMMON.FONT_DefaultName,CONST_COMMON.FONT_DefaultSize,16777215,true);
         _loc2_.color = 8453888;
         this.FTFMaxFps = this.ConstructTextField(this,_loc2_,7,5);
         this.FTFMinFps = this.ConstructTextField(this,_loc2_,7,37);
         _loc2_.color = 5614335;
         this.FTFMaxMem = this.ConstructTextField(this,_loc2_,7,50);
         this.FTFMinMem = this.ConstructTextField(this,_loc2_,7,83);
         this.ConstructBackground();
      }
      
      protected function ConstructBackground() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:Graphics = null;
         _loc1_ = FUICore.StageWidth;
         _loc2_ = FUICore.StageHeight;
         _loc3_ = this.FShapeBox.graphics;
         _loc3_.clear();
         _loc3_.beginFill(0,0.3);
         _loc3_.drawRect(0,0,_loc1_,120);
         _loc3_.lineStyle(1,16777215,0.2);
         _loc3_.moveTo(65,45);
         _loc3_.lineTo(65,10);
         _loc3_.moveTo(65,45);
         _loc3_.lineTo(_loc1_ - 15,45);
         _loc3_.moveTo(65,90);
         _loc3_.lineTo(65,55);
         _loc3_.moveTo(65,90);
         _loc3_.lineTo(_loc1_ - 15,90);
         _loc3_.endFill();
         this.FTFInfo.x = 65;
      }
      
      protected function ConstructTextField(param1:TUIComponent, param2:TextFormat, param3:uint = 0, param4:uint = 0, param5:uint = 0, param6:uint = 0, param7:String = "left") : TextField
      {
         var _loc8_:TextField = null;
         _loc8_ = new TextField();
         _loc8_.defaultTextFormat = param2;
         _loc8_.x = param3;
         _loc8_.y = param4;
         _loc8_.width = param5;
         _loc8_.height = param6;
         _loc8_.autoSize = param7;
         param1.addChild(_loc8_);
         return _loc8_;
      }
      
      public function Update(param1:String, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:String, param8:String, param9:Number, param10:Number, param11:Number, param12:Array, param13:Array, param14:int) : void
      {
         var _loc15_:Number = NaN;
         var _loc16_:Graphics = null;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:String = null;
         if(param2 >= 1)
         {
            this.FTFMaxFps.text = param4.toFixed(3) + " Fps";
            this.FTFMinFps.text = param3.toFixed(3) + " Fps";
            this.FTFMaxMem.text = param6.toFixed(3) + " Mb";
            this.FTFMinMem.text = param5.toFixed(3) + " Mb";
         }
         _loc23_ = TUtilityString.Format(this.FORMAT_INFO,param1,param7,param8,param9.toFixed(3),param11.toFixed(3),param10.toFixed(3));
         if(!TUtilityString.Empty(this.FTFInfo.text))
         {
            if(this.FTFInfo.text != _loc23_)
            {
               this.FTFInfo.text = _loc23_;
            }
         }
         else
         {
            this.FTFInfo.text = _loc23_;
         }
         this.FTFInfo.x = 65;
         _loc16_ = this.FShapeFps.graphics;
         _loc16_.clear();
         _loc16_.lineStyle(1,3407616,0.7);
         _loc17_ = 0;
         _loc18_ = int(param12.length);
         _loc20_ = 35;
         _loc19_ = FUICore.StageWidth - 80;
         _loc21_ = _loc19_ / (param14 - 1);
         _loc22_ = param4 - param3;
         while(_loc17_ < _loc18_)
         {
            _loc15_ = (param12[_loc17_] - param3) / _loc22_;
            if(_loc17_ == 0)
            {
               _loc16_.moveTo(0,-_loc15_ * _loc20_);
            }
            else
            {
               _loc16_.lineTo(_loc17_ * _loc21_,-_loc15_ * _loc20_);
            }
            _loc17_++;
         }
         _loc16_ = this.FShapeMb.graphics;
         _loc16_.clear();
         _loc16_.lineStyle(1,26367,0.7);
         _loc17_ = 0;
         _loc18_ = int(param13.length);
         _loc22_ = param6 - param5;
         _loc17_ = 0;
         while(_loc17_ < _loc18_)
         {
            _loc15_ = (param13[_loc17_] - param5) / _loc22_;
            if(_loc17_ == 0)
            {
               _loc16_.moveTo(0,-_loc15_ * _loc20_);
            }
            else
            {
               _loc16_.lineTo(_loc17_ * _loc21_,-_loc15_ * _loc20_);
            }
            _loc17_++;
         }
      }
   }
}

