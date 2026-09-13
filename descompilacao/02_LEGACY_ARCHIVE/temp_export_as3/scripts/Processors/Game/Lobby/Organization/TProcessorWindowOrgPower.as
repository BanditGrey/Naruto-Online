package Processors.Game.Lobby.Organization
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_ORGANIZATION;
   import Resources.Strings.STRING_ORGANIZATION;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowOrgPower extends TProcessorLobbyWindow
   {
      
      protected static const MAX_POWERLIST_COUNT:uint = 8;
      
      protected var FMC:Sprite;
      
      protected var FMC_SelectElement:MovieClip;
      
      protected var FTF_PowerList:TextField;
      
      protected var FTF_Prompt:TextField;
      
      protected var FBtn_Ok:MovieClip;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FBtn_Master:MovieClip;
      
      protected var FBtn_Pendragon:MovieClip;
      
      protected var FBtn_Member:MovieClip;
      
      protected var FPowerListVect:Vector.<TextField>;
      
      protected var FOrg_Powerman:Object;
      
      protected var FOrg_Power:Vector.<String>;
      
      protected var FOrg_PowerAssign:Array = [[0,0,0,0,0,1],[0,1,1,0,0,1],[1,1,1,1,1,1]];
      
      public function TProcessorWindowOrgPower(param1:TUIComponent)
      {
         super(param1);
         this.FPowerListVect = new Vector.<TextField>();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_ORGANIZATION.RESOURCESID_Swf_OrganizationMain);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TextField = null;
         this.FMC = TUtilityReflection.CreateDisplayObjectInstance(CONST_ORGANIZATION.RESOURCE_ClassName_MC_OrgPower) as Sprite;
         addChild(this.FMC);
         this.FMC_SelectElement = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_MC_SelectElement];
         this.FMC_SelectElement.play();
         this.FTF_Prompt = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_TF_Prompt];
         this.FBtn_Ok = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_Btn_Ok];
         this.FBtn_Close = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_BTN_Close];
         this.FBtn_Master = this.FMC["Btn_Master"];
         this.FBtn_Pendragon = this.FMC["Btn_Pendragon"];
         this.FBtn_Member = this.FMC["Btn_Member"];
         TGameUtil.setButtonMode(this.FBtn_Master,true);
         TGameUtil.setButtonMode(this.FBtn_Pendragon,true);
         TGameUtil.setButtonMode(this.FBtn_Member,true);
         TGameUtil.setButtonMode(this.FBtn_Ok,true);
         this.FOrg_Power = STRING_ORGANIZATION.FORMAT_OrgPowerElementVect;
         _loc1_ = 0;
         while(_loc1_ < MAX_POWERLIST_COUNT)
         {
            _loc3_ = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_TF_PowerList + _loc1_];
            _loc3_.text = "";
            this.FPowerListVect[_loc1_] = _loc3_;
            _loc1_++;
         }
         this.UpdateUI(2);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_Master.addEventListener(MouseEvent.CLICK,this.OnClickMasterPower);
         this.FBtn_Pendragon.addEventListener(MouseEvent.CLICK,this.OnClickPendragonPower);
         this.FBtn_Member.addEventListener(MouseEvent.CLICK,this.OnClickMemberPower);
         this.FBtn_Ok.addEventListener(MouseEvent.CLICK,OnClose);
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,OnClose);
         super.ResourcesPerform_UILocations();
      }
      
      protected function UpdateUI(param1:uint) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         _loc5_ = new Array();
         _loc4_ = this.FOrg_PowerAssign[param1];
         _loc3_ = int(_loc4_.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(_loc4_[_loc2_] == 1)
            {
               _loc5_.push(_loc2_);
            }
            _loc2_++;
         }
         _loc3_ = int(_loc5_.length);
         _loc2_ = 0;
         while(_loc2_ < MAX_POWERLIST_COUNT)
         {
            if(_loc2_ < _loc3_)
            {
               this.FPowerListVect[_loc2_].text = this.FOrg_Power[_loc5_[_loc2_]];
            }
            else
            {
               this.FPowerListVect[_loc2_].text = "";
            }
            _loc2_++;
         }
      }
      
      protected function OnClickMasterPower(param1:MouseEvent) : void
      {
         this.UpdateUI(2);
         this.FMC_SelectElement.y = param1.currentTarget.y - 10;
      }
      
      protected function OnClickPendragonPower(param1:MouseEvent) : void
      {
         this.UpdateUI(1);
         this.FMC_SelectElement.y = param1.currentTarget.y - 10;
      }
      
      protected function OnClickMemberPower(param1:MouseEvent) : void
      {
         this.UpdateUI(0);
         this.FMC_SelectElement.y = param1.currentTarget.y - 10;
      }
   }
}

