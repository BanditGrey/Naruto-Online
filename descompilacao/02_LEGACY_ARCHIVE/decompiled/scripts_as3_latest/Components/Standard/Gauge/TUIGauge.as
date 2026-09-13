package Components.Standard.Gauge
{
   import Foundation.Utilities.*;
   import Resources.Constants.*;
   import flash.display.*;
   import flash.text.*;
   
   public class TUIGauge
   {
      
      public static const MODE_PROGRESS_PERCENTAGE:uint = 1;
      
      public static const MODE_PROGRESS_SEPARATION:uint = 2;
      
      public static const TYPE_LABLE_None:uint = 0;
      
      public static const TYPE_LABLE_PERCENTAGE:uint = 1;
      
      public static const TYPE_LABLE_CAPACITY:uint = 2;
      
      public static const TYPE_LABLE_CAPACITY_AND_PERCENTAGE:uint = 3;
      
      protected var FUIProgressBar:MovieClip;
      
      protected var FTF_Lable:TextField;
      
      protected var FMC_Effect:MovieClip;
      
      protected var FRatio:Number;
      
      protected var FResource:MovieClip;
      
      protected var FModeGauge:uint;
      
      protected var FTypeLabel:uint;
      
      protected var FIsScale:Boolean;
      
      protected var FMinimum:int;
      
      protected var FMaximum:int;
      
      protected var FValue:int;
      
      protected var FLastRatio:Number;
      
      protected var FIsLoadMode:Boolean;
      
      protected var FInitialization:Boolean;
      
      public function TUIGauge()
      {
         super();
         this.FIsLoadMode = false;
         this.FInitialization = false;
      }
      
      protected function ResourcesPerform_UIDispatch() : void
      {
         this.FUIProgressBar = this.FResource["MC_ProgressBar"];
         this.FTF_Lable = this.FResource["TF_Value"];
         this.FMC_Effect = this.FResource["MC_Effect"];
         this.Reset();
         this.FInitialization = true;
      }
      
      protected function UpdateUIGauge() : void
      {
         if(this.FMinimum == this.FMaximum)
         {
            this.FRatio = 0;
         }
         else
         {
            this.FRatio = (this.FValue - this.FMinimum) / (this.FMaximum - this.FMinimum);
         }
         if(this.FRatio < 0)
         {
            this.FRatio = 0;
         }
         if(this.FRatio > 1)
         {
            this.FRatio = 1;
         }
         if(this.FIsLoadMode)
         {
            if(this.FLastRatio > 0)
            {
               if(this.FRatio < this.FLastRatio)
               {
                  this.FRatio = this.FLastRatio;
               }
            }
            this.FLastRatio = this.FRatio;
         }
         this.RenderingPerform_Gauge();
         if(this.FResource.totalFrames > 1 && !this.FResource.isPlaying)
         {
            this.FResource.play();
         }
         if(this.FUIProgressBar.totalFrames > 1 && !this.FUIProgressBar.isPlaying)
         {
            this.FUIProgressBar.play();
         }
         if(this.FMC_Effect != null)
         {
            if(!this.FMC_Effect.isPlaying)
            {
               this.FMC_Effect.play();
            }
         }
      }
      
      protected function RenderingPerform_Gauge() : void
      {
         var _loc1_:String = null;
         var _loc2_:uint = 0;
         _loc2_ = Math.round(this.FRatio * 100);
         if(this.FModeGauge == MODE_PROGRESS_SEPARATION)
         {
            _loc2_ = Math.round(_loc2_ / 10 + 1);
            this.FUIProgressBar.gotoAndStop(_loc2_);
         }
         if(this.FTF_Lable != null)
         {
            _loc1_ = "";
            if(this.FTypeLabel == TYPE_LABLE_PERCENTAGE)
            {
               _loc1_ = TUtilityString.Format(CONST_COMMON.STRING_Percentage,_loc2_);
            }
            else if(this.FTypeLabel == TYPE_LABLE_CAPACITY)
            {
               _loc1_ = TUtilityString.Format(CONST_COMMON.STRING_Capacity,this.FValue,this.FMaximum);
            }
            else if(this.FTypeLabel == TYPE_LABLE_CAPACITY_AND_PERCENTAGE)
            {
               _loc1_ = TUtilityString.Format(CONST_COMMON.STRING_CapacityAndPercentage,this.FValue,this.FMaximum,_loc2_);
            }
            this.FTF_Lable.text = _loc1_;
         }
      }
      
      public function set Resource(param1:MovieClip) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1 != this.FResource)
         {
            this.FResource = param1;
         }
         if(!this.FInitialization)
         {
            this.ResourcesPerform_UIDispatch();
         }
      }
      
      public function set ModeGauge(param1:uint) : void
      {
         this.FModeGauge = param1;
      }
      
      public function set TypeLabel(param1:uint) : void
      {
         this.FTypeLabel = param1;
      }
      
      public function set IsScale(param1:Boolean) : void
      {
         this.FIsScale = param1;
      }
      
      public function get Minimum() : int
      {
         return this.FMinimum;
      }
      
      public function set Minimum(param1:int) : void
      {
         this.FMinimum = param1;
      }
      
      public function get Maximum() : int
      {
         return this.FMaximum;
      }
      
      public function set Maximum(param1:int) : void
      {
         this.FMaximum = param1;
      }
      
      public function get Value() : int
      {
         return this.FValue;
      }
      
      public function set Value(param1:int) : void
      {
         this.FValue = param1;
      }
      
      public function get Ratio() : Number
      {
         return this.FRatio;
      }
      
      public function get IsLoadMode() : Boolean
      {
         return this.FIsLoadMode;
      }
      
      public function set IsLoadMode(param1:Boolean) : void
      {
         if(param1)
         {
            this.FLastRatio = 0;
         }
         this.FIsLoadMode = param1;
      }
      
      public function Reset() : void
      {
         this.FMinimum = 0;
         this.FMaximum = 100;
         this.FValue = 0;
         this.FLastRatio = 0;
         if(this.FTF_Lable != null)
         {
            this.FTF_Lable.text = "";
         }
         if(this.FResource.totalFrames > 1 && this.FResource.isPlaying)
         {
            this.FResource.stop();
         }
         if(this.FUIProgressBar.totalFrames > 1 && this.FUIProgressBar.isPlaying)
         {
            this.FUIProgressBar.stop();
         }
         if(this.FMC_Effect != null)
         {
            this.FMC_Effect.stop();
         }
      }
      
      public function Dispose() : void
      {
         this.Reset();
         this.FRatio = NaN;
         this.FTF_Lable = null;
         this.FUIProgressBar = null;
         this.FMC_Effect = null;
         this.FResource = null;
      }
      
      public function Update() : void
      {
         this.UpdateUIGauge();
      }
   }
}

