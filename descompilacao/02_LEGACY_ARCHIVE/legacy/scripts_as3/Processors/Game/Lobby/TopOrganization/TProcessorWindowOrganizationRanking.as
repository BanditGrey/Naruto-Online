package Processors.Game.Lobby.TopOrganization
{
   import Components.Pages.TUIPage;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.SLogicsCore;
   import Logics.TopOrganization.TSequenceRanking;
   import Logics.TopOrganization.TTopOrganizationData;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.TopOrganization.Componets.TUIWinStreak;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_TOPORGANIZATION;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowOrganizationRanking extends TProcessorLobbyWindow
   {
      
      protected const CAPACITY_Items:uint = 10;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FMC_FrontThree:Sprite;
      
      protected var FUIPage:TUIPage;
      
      protected var FPageIndex:int;
      
      protected var FUIWinStreaks:Vector.<TUIWinStreak>;
      
      protected var FTopOrganizationData:TTopOrganizationData;
      
      public function TProcessorWindowOrganizationRanking(param1:TUIComponent)
      {
         super(param1);
         this.FUIWinStreaks = new Vector.<TUIWinStreak>();
         this.FUIPage = new TUIPage(this);
         this.FTopOrganizationData = SLogicsCore.TopOrganizationData;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TOPORGANIZATION.RESOURCESID_Swf_TopOrganization);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:Sprite = null;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TextField = null;
         var _loc6_:MovieClip = null;
         var _loc7_:TUIWinStreak = null;
         TGameUtil.AddWindowMask(this);
         _loc1_ = TUtilityReflection.CreateDisplayObjectInstance(CONST_TOPORGANIZATION.RESOURCE_ClassName_MC_OrganizationRanking) as Sprite;
         addChild(_loc1_);
         _loc1_.x = (CONST_COMMON.STAGE_Width - _loc1_.width) / 2;
         _loc1_.y = (CONST_COMMON.STAGE_Height - _loc1_.height) / 2;
         this.FBTN_Close = _loc1_["BTN_Close"];
         _loc4_ = _loc1_["MC_ChangePage"]["MC_PageLeft"];
         this.FUIPage.ButtonPrevious.Substrate = _loc4_;
         _loc4_ = _loc1_["MC_ChangePage"]["MC_PageRight"];
         this.FUIPage.ButtonNext.Substrate = _loc4_;
         _loc5_ = _loc1_["MC_ChangePage"]["TF_Page"];
         this.FUIPage.LabelPage = _loc5_;
         this.FUIPage.PageSize = this.CAPACITY_Items;
         this.FUIPage.Init();
         _loc3_ = this.CAPACITY_Items;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc7_ = new TUIWinStreak(this);
            _loc7_.Tag = _loc2_;
            _loc6_ = _loc1_["MC_Hero_" + _loc2_] as MovieClip;
            _loc7_.Resource = _loc6_;
            _loc7_.Init();
            this.FUIWinStreaks[_loc2_] = _loc7_;
            _loc2_++;
         }
         this.FMC_FrontThree = _loc1_["MC_FrontThree"] as Sprite;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.ButtonCloseOnClick,false,0,true);
         this.FUIPage.OnChangePage = this.PageOnChange;
         super.ResourcesPerform_UILocations();
      }
      
      protected function UpdateUIRankings() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:TUIWinStreak = null;
         var _loc5_:TSequenceRanking = null;
         _loc2_ = this.CAPACITY_Items;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = _loc1_ + this.CAPACITY_Items * this.FPageIndex;
            _loc4_ = this.FUIWinStreaks[_loc1_];
            _loc5_ = this.FTopOrganizationData.SequenceRankings.GetTopOrganizationReportByIndex(_loc3_);
            if(_loc3_ >= this.FTopOrganizationData.SequenceRankings.Count)
            {
               _loc4_.Resource.visible = false;
               _loc4_.Context = null;
            }
            else
            {
               _loc4_.Resource.visible = true;
               _loc4_.Context = _loc5_;
               _loc4_.Update();
            }
            _loc1_++;
         }
         this.FMC_FrontThree.visible = this.FPageIndex <= 0;
      }
      
      protected function UpdatePageInfo() : void
      {
         this.FPageIndex = 0;
         this.FUIPage.TotalQuantity = this.FTopOrganizationData.SequenceRankings.Count;
         this.FUIPage.PageIndex = this.FPageIndex;
         this.FUIPage.Update();
      }
      
      protected function ButtonCloseOnClick(param1:MouseEvent) : void
      {
         if(FOnClose != null)
         {
            FOnClose(this);
         }
      }
      
      protected function PageOnChange(param1:Object, param2:int) : void
      {
         if(param2 == this.FPageIndex)
         {
            return;
         }
         this.FPageIndex = param2;
         this.UpdateUIRankings();
      }
      
      public function UpdateRankings() : void
      {
         this.UpdatePageInfo();
         this.UpdateUIRankings();
      }
   }
}

