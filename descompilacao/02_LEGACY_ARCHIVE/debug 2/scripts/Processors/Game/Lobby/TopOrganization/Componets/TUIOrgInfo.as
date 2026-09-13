package Processors.Game.Lobby.TopOrganization.Componets
{
   import Components.ScrollBar.TScrollBar;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.SLogicsCore;
   import Logics.TopOrganization.TGVG3BattleOrg;
   import Logics.TopOrganization.TOrgMemberDigest;
   import Logics.TopOrganization.TOrgMemberDigests;
   import Logics.TopOrganization.TTopOrganizationData;
   import Processors.Game.Lobby.Common.TProcessorUIResourceTemplate;
   import Resources.Constants.CONST_TOPORGANIZATION;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class TUIOrgInfo extends TProcessorUIResourceTemplate
   {
      
      protected var FTF_OrgName:TextField;
      
      protected var FTF_ServerName:TextField;
      
      protected var FTF_Population:TextField;
      
      protected var FMC_UISingleMembers:Vector.<TUISingleMember>;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FTopOrganizationData:TTopOrganizationData;
      
      public function TUIOrgInfo(param1:TUIComponent)
      {
         super(param1);
         this.FMC_UISingleMembers = new Vector.<TUISingleMember>();
         this.FTopOrganizationData = SLogicsCore.TopOrganizationData;
      }
      
      override protected function UIDispatch() : void
      {
         this.FTF_OrgName = FResource["TF_OrgName"];
         this.FTF_ServerName = FResource["TF_ServerName"];
         this.FTF_Population = FResource["TF_Population"];
         this.FScrollBar = new TScrollBar(FResource["mc_list"],304,false);
      }
      
      override protected function UILocations() : void
      {
         super.UILocations();
      }
      
      override protected function UpdateUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TGVG3BattleOrg = null;
         if(FContext == null)
         {
            this.Reset();
            return;
         }
         _loc3_ = FContext as TGVG3BattleOrg;
         this.FTF_OrgName.text = _loc3_.OrgName;
         this.FTF_ServerName.text = _loc3_.ServerName;
         this.FTF_Population.text = _loc3_.OrgMemberCount.toString();
      }
      
      protected function UpdateMembersInfoUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TOrgMemberDigests = null;
         var _loc4_:TOrgMemberDigest = null;
         var _loc5_:TUISingleMember = null;
         var _loc6_:TGVG3BattleOrg = null;
         if(FContext == null)
         {
            return;
         }
         _loc6_ = FContext as TGVG3BattleOrg;
         _loc3_ = _loc6_.OrgMemberDigests;
         _loc3_.Sort();
         _loc2_ = uint(_loc3_.Count);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc5_ = this.FMC_UISingleMembers[_loc1_];
            _loc4_ = _loc3_.GetOrgMemberDigestByIndex(_loc1_);
            _loc5_.Context = _loc4_;
            _loc5_.Update();
            _loc1_++;
         }
      }
      
      protected function CreateUISingleMembers() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISingleMember = null;
         var _loc4_:MovieClip = null;
         var _loc5_:TOrgMemberDigests = null;
         var _loc6_:TOrgMemberDigest = null;
         var _loc7_:TGVG3BattleOrg = null;
         _loc7_ = FContext as TGVG3BattleOrg;
         _loc5_ = _loc7_.OrgMemberDigests;
         _loc2_ = this.FMC_UISingleMembers.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_UISingleMembers[_loc1_];
            _loc3_.StubReferences.Dereference(this);
            _loc1_++;
         }
         this.FMC_UISingleMembers.length = 0;
         this.FScrollBar.Clear();
         _loc2_ = uint(_loc5_.Count);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = SLogicsCore.PoolUIOrgMember.AcquireUISingleMember(this);
            _loc3_.StubReferences.Reference(this);
            _loc4_ = TUtilityReflection.CreateDisplayObjectInstance(CONST_TOPORGANIZATION.RESOURCE_ClassName_MC_UISingleMember) as MovieClip;
            _loc3_.Resource = _loc4_;
            _loc3_.Init();
            this.FMC_UISingleMembers[_loc1_] = _loc3_;
            this.FScrollBar.AddItem(_loc3_);
            _loc1_++;
         }
         this.FScrollBar.ScrollToUp();
      }
      
      override public function Update() : void
      {
         this.UpdateUI();
         this.CreateUISingleMembers();
         this.UpdateMembersInfoUI();
      }
      
      public function UpdateMembersInfo() : void
      {
         this.UpdateMembersInfoUI();
      }
      
      override public function Reset() : void
      {
         this.FTF_OrgName.text = "";
         this.FTF_ServerName.text = "";
         this.FTF_Population.text = "";
      }
   }
}

