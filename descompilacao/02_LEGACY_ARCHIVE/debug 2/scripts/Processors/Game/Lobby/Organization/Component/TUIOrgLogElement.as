package Processors.Game.Lobby.Organization.Component
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Resources.Strings.STRING_ORGANIZATION;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class TUIOrgLogElement extends TUIComponent
   {
      
      protected static const FORMAT_TimeVect:Vector.<String> = STRING_ORGANIZATION.FORMAT_TimeVect;
      
      protected var FMC:Sprite;
      
      protected var FMC_Bg:MovieClip;
      
      protected var FTF_Log:TextField;
      
      protected var FTF_Time:TextField;
      
      protected var FData_Log:Object;
      
      protected var FIndex:uint;
      
      protected var FIsInitialization:Boolean;
      
      protected var FVerbTypeVect:Vector.<String>;
      
      public function TUIOrgLogElement(param1:TUIComponent)
      {
         super(param1);
      }
      
      protected function Resources_UIDispatch() : void
      {
         this.FMC = TUtilityReflection.CreateDisplayObjectInstance("MC_OrgLogLi") as Sprite;
         addChild(this.FMC);
         this.FMC_Bg = this.FMC["MC_Bg"];
         this.FTF_Log = this.FMC["TF_Log"];
         this.FTF_Time = this.FMC["TF_Time"];
         this.FVerbTypeVect = STRING_ORGANIZATION.FORMAT_VerbTypeVect;
      }
      
      protected function UpdateUI() : void
      {
         if(this.FIndex % 2 == 1)
         {
            this.FMC_Bg.gotoAndStop(2);
         }
         else
         {
            this.FMC_Bg.gotoAndStop(1);
         }
         if(this.FData_Log != null)
         {
            this.FTF_Log.text = String(this.FData_Log.subject + this.FVerbTypeVect[this.FData_Log.verbType] + this.FData_Log.object);
            this.FTF_Time.text = this.FormatTime();
         }
         else
         {
            this.FTF_Log.text = "";
            this.FTF_Time.text = "";
         }
      }
      
      protected function FormatTime() : String
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:String = null;
         _loc3_ = "";
         _loc2_ = uint(STimingCore.GetServerTick());
         _loc1_ = Math.floor((_loc2_ - this.FData_Log.time) / 3600);
         if(_loc1_ < 1)
         {
            _loc1_ = Math.floor(_loc1_ / 60);
            if(_loc1_ < 1)
            {
               _loc1_ = 0;
            }
            _loc3_ = _loc1_ + FORMAT_TimeVect[0];
         }
         else if(_loc1_ >= 1 && _loc1_ < 24)
         {
            _loc3_ = _loc1_ + FORMAT_TimeVect[1];
         }
         else if(_loc1_ >= 24 && _loc1_ < 72)
         {
            _loc3_ = FORMAT_TimeVect[2];
         }
         else if(_loc1_ >= 72 && _loc1_ < 168)
         {
            _loc3_ = FORMAT_TimeVect[3];
         }
         else
         {
            _loc3_ = FORMAT_TimeVect[4];
         }
         return _loc3_;
      }
      
      public function Perform_UIDispatch(param1:uint) : void
      {
         this.Resources_UIDispatch();
         this.FIndex = param1;
         this.FIsInitialization = true;
      }
      
      public function UpData(param1:Object) : void
      {
         this.FData_Log = param1;
      }
      
      public function UpDateUI() : void
      {
         this.UpdateUI();
      }
   }
}

