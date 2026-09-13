package Processors.Game.Lobby.TopOrganization
{
   import Components.Pages.TUIPage;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.SLogicsCore;
   import Logics.TopOrganization.TStatusJoinMember;
   import Logics.TopOrganization.TStatusJoinMembers;
   import Logics.TopOrganization.TTopOrganizationData;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.TopOrganization.Componets.TUIMemberItem;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_TOPORGANIZATION;
   import Resources.Strings.STRING_TOPORGANIZATION;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowJoinMember extends TProcessorLobbyWindow
   {
      
      protected const CAPACITY_Items:uint = 12;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FTF_Explanation:TextField;
      
      protected var FUIPage:TUIPage;
      
      protected var FPageIndex:int;
      
      protected var FUIMemberItems:Vector.<TUIMemberItem>;
      
      protected var FTopOrganizationData:TTopOrganizationData;
      
      protected var FType:uint;
      
      public function TProcessorWindowJoinMember(param1:TUIComponent)
      {
         super(param1);
         this.FUIMemberItems = new Vector.<TUIMemberItem>();
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
         var _loc7_:TUIMemberItem = null;
         TGameUtil.AddWindowMask(this);
         _loc1_ = TUtilityReflection.CreateDisplayObjectInstance(CONST_TOPORGANIZATION.RESOURCE_ClassName_MC_JoinList) as Sprite;
         addChild(_loc1_);
         _loc1_.x = (CONST_COMMON.STAGE_Width - _loc1_.width) / 2;
         _loc1_.y = (CONST_COMMON.STAGE_Height - _loc1_.height) / 2;
         this.FBTN_Close = _loc1_["BTN_Close"];
         this.FTF_Explanation = _loc1_["TF_Explanation"];
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
            _loc7_ = new TUIMemberItem(this);
            _loc6_ = _loc1_["MC_Member_" + _loc2_] as MovieClip;
            _loc7_.Tag = _loc2_;
            _loc7_.Resource = _loc6_;
            _loc7_.Init();
            this.FUIMemberItems[_loc2_] = _loc7_;
            _loc2_++;
         }
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.ButtonCloseOnClick,false,0,true);
         this.FUIPage.OnChangePage = this.PageOnChange;
         super.ResourcesPerform_UILocations();
      }
      
      protected function UpdateUIMembers() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIMemberItem = null;
         var _loc4_:TStatusJoinMember = null;
         var _loc5_:TStatusJoinMembers = null;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         if(this.FType == CONST_TOPORGANIZATION.TYPE_GVG1_Join)
         {
            _loc7_ = this.FTopOrganizationData.ApplyName;
            _loc5_ = this.FTopOrganizationData.StatusJoinMembers;
         }
         else if(this.FType == CONST_TOPORGANIZATION.TYPE_GVG2_Join)
         {
            _loc7_ = this.FTopOrganizationData.ApplyGVG2Name;
            _loc5_ = this.FTopOrganizationData.StatusJoinGVG2Members;
         }
         this.FTF_Explanation.text = TUtilityString.Format(STRING_TOPORGANIZATION.FORMAT_WhoApply,_loc7_);
         _loc2_ = this.CAPACITY_Items;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUIMemberItems[_loc1_];
            _loc3_.Resource.visible = false;
            _loc1_++;
         }
         _loc2_ = this.CAPACITY_Items;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUIMemberItems[_loc1_];
            _loc6_ = _loc1_ + this.FPageIndex * this.CAPACITY_Items;
            if(_loc6_ >= _loc5_.Count)
            {
               break;
            }
            _loc4_ = _loc5_.GetStatusJoinMemberByIndex(_loc6_);
            _loc3_.Tag = _loc6_;
            _loc3_.Context = _loc4_;
            _loc3_.Update();
            _loc3_.Resource.visible = true;
            _loc1_++;
         }
      }
      
      protected function UpdatePageInfo() : void
      {
         var _loc1_:uint = 0;
         this.FPageIndex = 0;
         if(this.FType == CONST_TOPORGANIZATION.TYPE_GVG1_Join)
         {
            _loc1_ = this.FTopOrganizationData.StatusJoinMembers.Count;
         }
         else
         {
            _loc1_ = this.FTopOrganizationData.StatusJoinGVG2Members.Count;
         }
         this.FUIPage.TotalQuantity = _loc1_;
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
         this.UpdateUIMembers();
      }
      
      public function Update(param1:uint = 1) : void
      {
         this.FType = param1;
         this.UpdatePageInfo();
         this.UpdateUIMembers();
      }
   }
}

