package Processors.Game.Effects
{
   import Foundation.Common.TCoordinate;
   import Foundation.Fonts.SFontCore;
   import Foundation.Fonts.TFontEffect;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Processors.Game.Common.Effects.TEffectLayer;
   import Processors.Game.Common.Effects.TProcessorEffect;
   import Processors.Game.Common.Effects.Texts.TEffectCoordinateParameters;
   import Processors.Game.Common.Effects.Texts.TEffectTextLinearCrossfade;
   import Processors.Game.Common.Effects.Texts.TEffectTextParameters;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_EFFECT;
   
   public class TProcessorRootEffect extends TProcessorEffect
   {
      
      protected static const COORDINATE_TextX:int = 620;
      
      protected static const COORDINATE_TextY:int = 300;
      
      protected static const COLOR_EffectText:uint = 4294952980;
      
      public static const CAPACITY_ParallelOutputRows:uint = CONST_EFFECT.CAPACITY_ParallelOutputRows;
      
      protected static const SEQUENCEID_Default:uint = CONST_COMMON.SEQUENCEID_Default;
      
      protected var FLayerText:TEffectLayer;
      
      protected var FTextParameters:TEffectTextParameters;
      
      protected var FEffectCoordinateParameters:TEffectCoordinateParameters;
      
      protected var FCoordinateText:TCoordinate;
      
      public function TProcessorRootEffect(param1:TUIComponent)
      {
         super(param1);
         this.ConstructEffectFields();
         this.ConstructEffectParameters();
         this.FCoordinateText = new TCoordinate();
         this.mouseEnabled = false;
      }
      
      override protected function ConstructEffectLayers() : void
      {
         super.ConstructEffectLayers();
         this.FLayerText = ConstructEffectLayer();
      }
      
      protected function ConstructEffectFields() : void
      {
         this.ConstructEffectFields_Text();
      }
      
      protected function ConstructEffectParameters() : void
      {
         this.FEffectCoordinateParameters = new TEffectCoordinateParameters();
         this.FEffectCoordinateParameters.IsShakeEffect = true;
      }
      
      protected function ConstructEffectFields_Text() : void
      {
         var _loc1_:TFontEffect = null;
         this.FTextParameters = new TEffectTextParameters();
         this.FTextParameters.Font.Color = COLOR_EffectText;
         SFontCore.FontSelect(this.FTextParameters.Font,CONST_EFFECT.TEXT_DEFAULT_FontSetName,CONST_EFFECT.TEXT_DEFAULT_FontSetSize,CONST_EFFECT.TEXT_DEFAULT_FontSetBold);
      }
      
      protected function ImportingPerform_Text(param1:String, param2:TEffectTextParameters = null, param3:TEffectCoordinateParameters = null, param4:uint = 5) : void
      {
         var _loc5_:* = 0;
         var _loc6_:int = 0;
         var _loc7_:TEffectTextLinearCrossfade = null;
         var _loc8_:TEffectTextLinearCrossfade = null;
         this.FCoordinateText.X = COORDINATE_TextX;
         this.FCoordinateText.Y = COORDINATE_TextY;
         _loc7_ = FPoolEffect.AcquireTextLinearCrossfade(this);
         if(param2 != null)
         {
            _loc7_.SetupResources(param1,param2);
         }
         else
         {
            _loc7_.SetupResources(param1,this.FTextParameters);
         }
         if(param3 != null)
         {
            this.FEffectCoordinateParameters.Assign(param3);
            this.FCoordinateText.X = param3.X;
            this.FCoordinateText.Y = param3.Y;
         }
         else
         {
            this.FEffectCoordinateParameters.Reset();
         }
         _loc6_ = this.FLayerText.Count;
         if(this.FLayerText.Count > 0)
         {
            _loc5_ = int(_loc6_ - 1);
            while(_loc5_ >= 0)
            {
               _loc8_ = this.FLayerText.GetEffectByIndex(_loc5_) as TEffectTextLinearCrossfade;
               if(!_loc8_.IsParallelOutput)
               {
                  break;
               }
               if(_loc6_ - _loc5_ > param4)
               {
                  _loc8_.TerminateMovement();
               }
               else
               {
                  _loc8_.SourceY = this.FCoordinateText.Y - (_loc6_ - _loc5_) * 30;
               }
               _loc5_--;
            }
         }
         _loc7_.SetupMovement(this.FCoordinateText,STimingCore.TickCount,this.FEffectCoordinateParameters.FadeInTicks,this.FEffectCoordinateParameters.FadeOutTicks,this.FEffectCoordinateParameters.SustainTicks,this.FEffectCoordinateParameters.VelocityX,this.FEffectCoordinateParameters.VelocityY,this.FEffectCoordinateParameters.PauseTicks,this.FEffectCoordinateParameters.PauseSustainTicks,this.FEffectCoordinateParameters.IsShakeEffect,this.FEffectCoordinateParameters.IsScale,this.FEffectCoordinateParameters.IsParallelOutput);
         this.FLayerText.Add(_loc7_);
      }
      
      public function ImportText(param1:String, param2:TEffectTextParameters = null, param3:TEffectCoordinateParameters = null, param4:uint = 5) : void
      {
         this.ImportingPerform_Text(param1,param2,param3,param4);
      }
   }
}

