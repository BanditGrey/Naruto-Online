package Processors.Game.Lobby.Slave
{
   import Components.Pages.TUIPage;
   import Components.Standard.TUITab;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Mentorship.Elements.TArrestPlayer;
   import Logics.Mentorship.Elements.TRescuePlayer;
   import Logics.Mentorship.Elements.TSOSPlayer;
   import Logics.Mentorship.TArrest;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Mentorship.Components.TUIArrestItem;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_SLAVE;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_Mentorship;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowSlaveArrest extends TProcessorLobbyWindow
   {
      
      public static const STAGE_Width:Number = CONST_COMMON.STAGE_Width;
      
      public static const STAGE_Height:Number = CONST_COMMON.STAGE_Height;
      
      protected const TYPE_Failed:uint = 0;
      
      protected const TYPE_Rob:uint = 1;
      
      protected const Capacity_ArrestItems:uint = 11;
      
      protected var FMC_Arrest:Sprite;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FMC_ArrestPlayers:Sprite;
      
      protected var FMC_Nobody:Sprite;
      
      protected var FTF_Nobody:TextField;
      
      protected var FTF_Explanation:TextField;
      
      protected var FUITab:TUITab;
      
      protected var FTabIndex:int;
      
      protected var FUIPage:TUIPage;
      
      protected var FPageIndex:int;
      
      protected var FCurArrestList:Vector.<TArrestPlayer>;
      
      protected var FArrest:TArrest;
      
      protected var FUIItems:Vector.<TUIArrestItem>;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FCMDType:uint;
      
      protected var FSmallType:uint;
      
      protected var FIDHigh:uint;
      
      protected var FIDLow:uint;
      
      protected var FOnArrestPlayer:Function;
      
      public function TProcessorWindowSlaveArrest(param1:TUIComponent)
      {
         super(param1);
         this.FUITab = new TUITab(this);
         this.FUIPage = new TUIPage(this);
         this.FCurArrestList = new Vector.<TArrestPlayer>();
         this.FUIItems = new Vector.<TUIArrestItem>(this.Capacity_ArrestItems);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_SLAVE.RESOURCESID_Swf_Slave);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:TextField = null;
         var _loc6_:TUIArrestItem = null;
         this.FMC_Arrest = TUtilityReflection.CreateDisplayObjectInstance(CONST_SLAVE.RESOURCE_ClassName_MC_Arrest) as Sprite;
         addChild(this.FMC_Arrest);
         this.FBTN_Close = this.FMC_Arrest[CONST_SLAVE.RESOURCE_Link_BTN_Close];
         _loc2_ = 2;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_Arrest[CONST_SLAVE.RESOURCE_Link_MC_Tab + _loc1_];
            this.FUITab.SetTabByIndex(_loc3_,_loc1_);
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         this.FMC_ArrestPlayers = this.FMC_Arrest[CONST_SLAVE.RESOURCE_Link_MC_ArrestPlayers];
         this.FMC_Nobody = this.FMC_Arrest[CONST_SLAVE.RESOURCE_Link_MC_Nobody];
         this.FTF_Nobody = this.FMC_Nobody[CONST_SLAVE.RESOURCE_Link_TF_Nobody];
         this.FTF_Explanation = this.FMC_Arrest[CONST_SLAVE.RESOURCE_Link_TF_Explanation];
         _loc2_ = this.Capacity_ArrestItems;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc6_ = new TUIArrestItem(this);
            _loc6_.Resource = this.FMC_ArrestPlayers[CONST_SLAVE.RESOURCE_Link_MC_Disciple + _loc1_];
            _loc6_.OnDynamicFunction = this.ProcessorOnArrestPlayer;
            _loc6_.Init();
            this.FUIItems[_loc1_] = _loc6_;
            _loc1_++;
         }
         _loc4_ = this.FMC_Arrest[CONST_SLAVE.RESOURCE_Link_MC_PageLeft];
         this.FUIPage.ButtonPrevious.Substrate = _loc4_;
         _loc4_ = this.FMC_Arrest[CONST_SLAVE.RESOURCE_Link_MC_PageRight];
         this.FUIPage.ButtonNext.Substrate = _loc4_;
         _loc5_ = this.FMC_Arrest[CONST_SLAVE.RESOURCE_Link_TF_Page];
         this.FUIPage.LabelPage = _loc5_;
         _loc5_.text = "0/0";
         this.FUIPage.PageSize = this.Capacity_ArrestItems;
         this.FUIPage.Init();
         this.FUIPage.OnChangePage = this.PageOnChange;
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowConfirmation.OnOK = this.WindowInformationOnOK;
         this.FUIWindowConfirmation.x = (STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.BTNCloseOnClick,false,0,true);
         super.ResourcesPerform_UILocations();
      }
      
      protected function FilterArrest() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TArrestPlayer = null;
         _loc2_ = this.FCurArrestList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FCurArrestList.pop();
            _loc1_++;
         }
         if(this.FArrest == null)
         {
            return;
         }
         _loc2_ = this.FArrest.ArrestList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FArrest.ArrestList[_loc1_];
            if(_loc3_.Type == this.FTabIndex)
            {
               this.FCurArrestList.push(_loc3_);
               if(this.FCurArrestList.length >= 10)
               {
               }
            }
            _loc1_++;
         }
      }
      
      protected function UpdateArrestItemsInfo() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TUIArrestItem = null;
         var _loc6_:TArrestPlayer = null;
         _loc2_ = this.FCurArrestList.length;
         _loc3_ = this.Capacity_ArrestItems;
         _loc4_ = _loc2_ - this.FPageIndex * _loc3_;
         if(_loc2_ <= 0)
         {
            this.FMC_ArrestPlayers.visible = false;
            return;
         }
         this.FMC_ArrestPlayers.visible = true;
         _loc1_ = 0;
         while(_loc1_ < _loc3_)
         {
            _loc5_ = this.FUIItems[_loc1_];
            _loc5_.Resource.visible = false;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc3_)
         {
            if(_loc1_ + this.FPageIndex * _loc3_ >= _loc2_)
            {
               break;
            }
            _loc5_ = this.FUIItems[_loc1_];
            _loc6_ = this.FCurArrestList[_loc1_ + this.FPageIndex * _loc3_];
            _loc5_.Update(_loc6_);
            _loc5_.Resource.visible = true;
            _loc1_++;
         }
      }
      
      protected function UpdatePageInfo() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TSystemLanguage = null;
         var _loc3_:uint = 0;
         if(this.FTabIndex == this.TYPE_Failed)
         {
            _loc3_ = CONST_SYSTEMLANGUAGE.NO_SLAVE_DEFEATED_HERO;
         }
         else if(this.FTabIndex == this.TYPE_Rob)
         {
            _loc3_ = CONST_SYSTEMLANGUAGE.NO_ENEMY_HERO;
         }
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,_loc3_) as TSystemLanguage;
         _loc1_ = this.FCurArrestList.length;
         if(_loc1_ > 0)
         {
            this.FPageIndex = 0;
            this.FUIPage.TotalQuantity = _loc1_;
            this.FUIPage.PageIndex = this.FPageIndex;
            this.FUIPage.Update();
            this.FMC_Nobody.visible = false;
         }
         else
         {
            this.FMC_Nobody.visible = true;
            this.FTF_Nobody.text = _loc2_.Desc;
         }
      }
      
      protected function UpdateExplanation() : void
      {
         this.FTF_Explanation.text = TUtilityString.GetText(CONST_SYSTEMLANGUAGE.STRING_ArrestList);
      }
      
      protected function BTNCloseOnClick(param1:MouseEvent) : void
      {
         ProcessorWindowClose();
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         if(param1 is int)
         {
            this.FTabIndex = param1 as int;
         }
         this.FilterArrest();
         this.UpdatePageInfo();
         this.UpdateArrestItemsInfo();
      }
      
      protected function PageOnChange(param1:Object, param2:int) : void
      {
         this.FPageIndex = param2;
         this.UpdateArrestItemsInfo();
      }
      
      protected function ProcessorOnArrestPlayer(param1:Object, param2:Object) : void
      {
         var _loc3_:TArrestPlayer = null;
         var _loc4_:TRescuePlayer = null;
         var _loc5_:TSOSPlayer = null;
         if(param2 is TArrestPlayer)
         {
            _loc3_ = param2 as TArrestPlayer;
            this.FCMDType = CONST_SLAVE.COMMAND_ArrestDisciple;
            this.FSmallType = _loc3_.Type;
            this.FIDHigh = _loc3_.Identifier0;
            this.FIDLow = _loc3_.Identifier1;
         }
         else if(param2 is TRescuePlayer)
         {
            _loc4_ = param2 as TRescuePlayer;
            this.FSmallType = 0;
            this.FCMDType = CONST_SLAVE.COMMAND_Rescue;
            this.FIDHigh = _loc4_.Identifier0;
            this.FIDLow = _loc4_.Identifier1;
         }
         else if(param2 is TSOSPlayer)
         {
            _loc5_ = param2 as TSOSPlayer;
            this.FSmallType = 0;
            this.FCMDType = CONST_SLAVE.COMMAND_SOS;
            this.FIDHigh = _loc5_.Identifier0;
            this.FIDLow = _loc5_.Identifier1;
         }
         switch(_loc3_.Identity)
         {
            case CONST_SLAVE.IDENTITY_Freedom:
               this.WindowInformationOnOK(null);
               break;
            case CONST_SLAVE.IDENTITY_Master:
               this.FUIWindowConfirmation.Visible = true;
               this.FUIWindowConfirmation.Text = STRING_Mentorship.STRING_FightWithMaster;
               break;
            case CONST_SLAVE.IDENTITY_Disciple:
               this.FUIWindowConfirmation.Visible = true;
               this.FUIWindowConfirmation.Text = TUtilityString.Format(STRING_Mentorship.FORMAT_FightWithMaster,_loc3_.MasterName);
         }
      }
      
      protected function WindowInformationOnOK(param1:Object) : void
      {
         if(this.FOnArrestPlayer != null)
         {
            this.FOnArrestPlayer(this,this.FCMDType,this.FSmallType,this.FIDHigh,this.FIDLow);
         }
      }
      
      public function get OnArrestPlayer() : Function
      {
         return this.FOnArrestPlayer;
      }
      
      public function set OnArrestPlayer(param1:Function) : void
      {
         this.FOnArrestPlayer = param1;
      }
      
      public function UpdateUI(param1:TArrest) : void
      {
         this.FArrest = param1;
         this.FTabIndex = 0;
         this.FUITab.SwithTagManual(this.FTabIndex);
         this.FilterArrest();
         this.UpdatePageInfo();
         this.UpdateArrestItemsInfo();
         this.UpdateExplanation();
      }
   }
}

