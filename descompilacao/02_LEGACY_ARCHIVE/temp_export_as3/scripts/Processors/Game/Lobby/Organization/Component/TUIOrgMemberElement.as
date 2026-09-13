package Processors.Game.Lobby.Organization.Component
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Organization.TBaseOrganizationMember;
   import Logics.SLogicsCore;
   import Resources.Strings.STRING_ORGANIZATION;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIOrgMemberElement extends TUIComponent
   {
      
      protected static const FORMAT_TimeVect:Vector.<String> = STRING_ORGANIZATION.FORMAT_TimeVect;
      
      protected static const FORMAT_OrgPowerNameVect:Vector.<String> = STRING_ORGANIZATION.FORMAT_OrgPowerNameVect;
      
      protected var FMC:Sprite;
      
      protected var FTF_Rank:TextField;
      
      protected var FTF_Name:TextField;
      
      protected var FTF_Level:TextField;
      
      protected var FTF_Power:TextField;
      
      protected var FTF_TodayContribution:TextField;
      
      protected var FTF_TotalContribution:TextField;
      
      protected var FTF_LastLoggin:TextField;
      
      protected var FMC_Bg:MovieClip;
      
      protected var FData_Member:TBaseOrganizationMember;
      
      protected var FIsInitialization:Boolean;
      
      protected var FIndex:uint;
      
      protected var FOriginalFrame:uint;
      
      protected var FClickMemberElement:Function;
      
      public function TUIOrgMemberElement(param1:TUIComponent)
      {
         super(param1);
      }
      
      protected function Resources_UIDispatch() : void
      {
         this.FMC = TUtilityReflection.CreateDisplayObjectInstance("MC_OrgMemberLi") as Sprite;
         addChild(this.FMC);
         this.FMC.mouseChildren = false;
         this.FMC.addEventListener(MouseEvent.CLICK,this.OnFmcClick);
         this.FMC.addEventListener(MouseEvent.MOUSE_OVER,this.OnFmcOver);
         this.FMC.addEventListener(MouseEvent.MOUSE_OUT,this.OnFmcOut);
         this.FTF_Rank = this.FMC["TF_Rank"];
         this.FTF_Name = this.FMC["TF_Name"];
         this.FTF_Level = this.FMC["TF_Level"];
         this.FTF_Power = this.FMC["TF_Power"];
         this.FTF_TodayContribution = this.FMC["TF_TodayContribution"];
         this.FTF_TotalContribution = this.FMC["TF_TotalContribution"];
         this.FTF_LastLoggin = this.FMC["TF_LastLoggin"];
         this.FMC_Bg = this.FMC["MC_Bg"];
      }
      
      protected function Update() : void
      {
         var _loc1_:String = null;
         this.FTF_Rank.text = String(this.FData_Member.Rank);
         this.FTF_Name.text = String(this.FData_Member.PlayerName);
         this.FTF_Level.text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(this.FData_Member.PlayerLevel);
         if(this.FData_Member.OrgDuties == 2)
         {
            _loc1_ = FORMAT_OrgPowerNameVect[0];
         }
         else if(this.FData_Member.OrgDuties == 1)
         {
            _loc1_ = FORMAT_OrgPowerNameVect[1];
         }
         else
         {
            _loc1_ = FORMAT_OrgPowerNameVect[2];
         }
         this.FTF_Power.text = _loc1_;
         this.FTF_TodayContribution.text = String(this.FData_Member.TodayContribution);
         this.FTF_TotalContribution.text = String(this.FData_Member.TotalContribution);
         this.FTF_LastLoggin.text = this.FormatTime();
         if(this.FIndex % 2 == 0)
         {
            this.FMC_Bg.gotoAndStop(1);
            this.FOriginalFrame = 1;
         }
         else
         {
            this.FMC_Bg.gotoAndStop(2);
            this.FOriginalFrame = 2;
         }
      }
      
      protected function FormatTime() : String
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:String = null;
         _loc3_ = "";
         _loc2_ = uint(STimingCore.GetServerTick());
         _loc1_ = Math.floor((_loc2_ - this.FData_Member.LastLogginTime) / 3600);
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
      
      protected function OnFmcClick(param1:MouseEvent) : void
      {
         if(this.FClickMemberElement != null)
         {
            this.FClickMemberElement(this,this.FData_Member.Identifier0,this.FData_Member.Identifier1,this.FData_Member.PlayerName);
         }
      }
      
      protected function OnFmcOver(param1:MouseEvent) : void
      {
         this.FMC_Bg.gotoAndStop(3);
      }
      
      protected function OnFmcOut(param1:MouseEvent) : void
      {
         this.FMC_Bg.gotoAndStop(this.FOriginalFrame);
      }
      
      public function get ClickMemberElement() : Function
      {
         return this.FClickMemberElement;
      }
      
      public function set ClickMemberElement(param1:Function) : void
      {
         this.FClickMemberElement = param1;
      }
      
      public function Perform_UIDispatch() : void
      {
         this.Resources_UIDispatch();
         this.FIsInitialization = true;
      }
      
      public function set Index(param1:uint) : void
      {
         this.FIndex = param1;
         if(this.FIndex % 2 == 0)
         {
            this.FMC_Bg.gotoAndStop(1);
            this.FOriginalFrame = 1;
         }
         else
         {
            this.FMC_Bg.gotoAndStop(2);
            this.FOriginalFrame = 2;
         }
      }
      
      public function UpData(param1:TBaseOrganizationMember, param2:uint) : void
      {
         this.FIndex = param2;
         this.FData_Member = param1;
      }
      
      public function UpDateUI() : void
      {
         this.Update();
      }
      
      public function get Data_Member() : TBaseOrganizationMember
      {
         return this.FData_Member;
      }
   }
}

