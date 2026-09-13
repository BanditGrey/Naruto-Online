package Processors.Game.Lobby.TopOrganization.Componets
{
   import Foundation.Common.Stubs.TStubReferences;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.SLogicsCore;
   import Logics.TopOrganization.TOrgMemberDigest;
   import Processors.Game.Lobby.Common.TProcessorUIResourceTemplate;
   import Resources.Constants.CONST_CHARACTER;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class TUISingleMember extends TProcessorUIResourceTemplate
   {
      
      protected var FTF_Name:TextField;
      
      protected var FTF_Level:TextField;
      
      protected var FMC_Icon:MovieClip;
      
      protected var FMC_Pass:MovieClip;
      
      protected var FStubReferences:TStubReferences;
      
      public function TUISingleMember(param1:TUIComponent)
      {
         super(param1);
         this.FStubReferences = new TStubReferences(this);
      }
      
      override protected function UIDispatch() : void
      {
         if(FResource != null)
         {
            addChild(FResource);
         }
         this.FTF_Name = FResource["TF_Name"];
         this.FTF_Level = FResource["TF_Level"];
         this.FMC_Icon = FResource["MC_Icon"];
         this.FMC_Pass = FResource["MC_Pass"];
      }
      
      override protected function UILocations() : void
      {
         super.UILocations();
      }
      
      override protected function UpdateUI() : void
      {
         var _loc1_:TOrgMemberDigest = null;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         if(FContext == null)
         {
            this.Reset();
            return;
         }
         _loc1_ = FContext as TOrgMemberDigest;
         this.FTF_Name.text = _loc1_.Name;
         this.FTF_Level.text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(_loc1_.Level);
         _loc4_ = _loc1_.TemplateID % CONST_CHARACTER.CHARACTER_BaseModeID;
         this.FMC_Icon.gotoAndStop(_loc4_);
         this.FMC_Icon.visible = true;
         _loc5_ = _loc1_.IsThreeWins;
         this.FMC_Pass.gotoAndStop(_loc5_ + 1);
         if(Boolean(_loc5_) || Boolean(_loc1_.IsDead))
         {
            this.FMC_Icon.filters = [TGameUtil.GaryColorFilters];
            this.FMC_Pass.visible = true;
         }
         else
         {
            this.FMC_Icon.filters = [];
            this.FMC_Pass.visible = false;
         }
      }
      
      public function get StubReferences() : TStubReferences
      {
         return this.FStubReferences;
      }
      
      override public function Reset() : void
      {
         super.Reset();
         this.FMC_Icon.visible = false;
      }
   }
}

