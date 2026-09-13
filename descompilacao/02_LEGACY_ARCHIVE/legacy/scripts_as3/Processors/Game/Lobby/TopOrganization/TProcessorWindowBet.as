package Processors.Game.Lobby.TopOrganization
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.SLogicsCore;
   import Logics.TopOrganization.TGVG3BetOrg;
   import Logics.TopOrganization.TGVG3BetOrgs;
   import Logics.TopOrganization.TUserBetInfo;
   import Logics.TopOrganization.TUserBetInfos;
   import Processors.Game.Lobby.Common.TProcessorWindowTemplate;
   import Processors.Game.Lobby.TopOrganization.Componets.TUIOrgBet;
   import Resources.Constants.CONST_TOPORGANIZATION;
   import flash.display.Sprite;
   
   public class TProcessorWindowBet extends TProcessorWindowTemplate
   {
      
      protected const CAPACITY_BetOrgs:uint = 2;
      
      protected var FMC_Background:Sprite;
      
      protected var FMC_OrgBets:Vector.<TUIOrgBet>;
      
      protected var FGVG3BetOrgs:TGVG3BetOrgs;
      
      protected var FBetOnClick:Function;
      
      public function TProcessorWindowBet(param1:TUIComponent)
      {
         super(param1);
         this.FMC_OrgBets = new Vector.<TUIOrgBet>(this.CAPACITY_BetOrgs);
         this.FGVG3BetOrgs = SLogicsCore.TopOrganizationData.GVG3BetOrgs;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TOPORGANIZATION.RESOURCESID_Swf_TopOrganization);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIOrgBet = null;
         FMainUI = TUtilityReflection.CreateDisplayObjectInstance(CONST_TOPORGANIZATION.RESOURCE_ClassName_MC_Bet) as Sprite;
         TGameUtil.AddWindowMask(this);
         UIDispatch();
         FMainUI.x += 60;
         _loc2_ = this.CAPACITY_BetOrgs;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = new TUIOrgBet(this);
            _loc3_.Resource = FMainUI["MC_OrgBet_" + _loc1_];
            _loc3_.Tag = _loc1_;
            _loc3_.BetOnClick = this.ProcessorBetOnClick;
            _loc3_.Init();
            this.FMC_OrgBets[_loc1_] = _loc3_;
            _loc1_++;
         }
         this.FMC_Background = FMainUI["MC_Background"];
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.UILocations();
      }
      
      protected function UpdateUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIOrgBet = null;
         var _loc4_:TGVG3BetOrg = null;
         var _loc5_:TUserBetInfos = null;
         var _loc6_:TUserBetInfo = null;
         _loc5_ = SLogicsCore.TopOrganizationData.UserBetInfos;
         _loc2_ = this.CAPACITY_BetOrgs;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_OrgBets[_loc1_];
            _loc4_ = this.FGVG3BetOrgs.GetGVG3BetOrgByIndex(_loc1_);
            _loc3_.Context = _loc4_;
            _loc3_.Update();
            _loc1_++;
         }
         _loc6_ = this.CheckCurrentRoundIsBet();
         if(_loc6_ != null)
         {
            _loc2_ = this.FGVG3BetOrgs.Count;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc4_ = this.FGVG3BetOrgs.GetGVG3BetOrgByIndex(_loc1_);
               this.FMC_Background.visible = !(_loc6_.AttackOrgID == _loc4_.OrgID || _loc6_.DefendOrgID == _loc4_.OrgID);
               _loc1_++;
            }
         }
         else
         {
            this.FMC_Background.visible = false;
         }
      }
      
      protected function CheckCurrentRoundIsBet() : TUserBetInfo
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUserBetInfos = null;
         var _loc4_:TUserBetInfo = null;
         _loc3_ = SLogicsCore.TopOrganizationData.UserBetInfos;
         _loc2_ = _loc3_.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = _loc3_.GetUserBetInfoByIndex(_loc1_);
            if(_loc4_.Round == SLogicsCore.TopOrganizationData.CurrentBetCircle)
            {
               return _loc4_;
            }
            _loc1_++;
         }
         return null;
      }
      
      protected function ProcessorBetOnClick(param1:Object, param2:Object, param3:int) : void
      {
         var _loc4_:TGVG3BetOrg = null;
         var _loc5_:TGVG3BetOrg = null;
         var _loc6_:TGVG3BetOrg = null;
         var _loc7_:int = 0;
         _loc6_ = param2 as TGVG3BetOrg;
         _loc4_ = this.FGVG3BetOrgs.GetGVG3BetOrgByIndex(0);
         _loc5_ = this.FGVG3BetOrgs.GetGVG3BetOrgByIndex(1);
         _loc7_ = this.FGVG3BetOrgs.GetIndex(_loc6_);
         if(this.FBetOnClick != null)
         {
            this.FBetOnClick(this,_loc4_.AgentID,_loc4_.ServerID,_loc4_.OrgID,_loc5_.AgentID,_loc5_.ServerID,_loc5_.OrgID,_loc7_,param3);
         }
      }
      
      public function set BetOnClick(param1:Function) : void
      {
         this.FBetOnClick = param1;
      }
      
      public function Update() : void
      {
         this.UpdateUI();
      }
   }
}

