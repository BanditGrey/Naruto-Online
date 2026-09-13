package Processors.Game.Lobby.Slave
{
   import Components.Pages.TUIPage;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Mentorship.Elements.TRescuePlayer;
   import Logics.Mentorship.Elements.TSOSPlayer;
   import Logics.Mentorship.TRescue;
   import Logics.Mentorship.TSOS;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Mentorship.Components.TUIArrestItem;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_SLAVE;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_Mentorship;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowSlaveRescue extends TProcessorLobbyWindow
   {
      
      protected const Capacity_RescueItems:uint = 12;
      
      protected var FMC_Rescue:Sprite;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FMC_RescuePlayers:Sprite;
      
      protected var FTF_Tittle:TextField;
      
      protected var FTF_DynamicTittle:TextField;
      
      protected var FMC_Nobody:Sprite;
      
      protected var FTF_Nobody:TextField;
      
      protected var FTF_Explanation:TextField;
      
      protected var FUIPage:TUIPage;
      
      protected var FPageIndex:int;
      
      protected var FUIItems:Vector.<TUIArrestItem>;
      
      protected var FObj:Object;
      
      protected var FCurrentList:Vector.<Object>;
      
      protected var FOnRescuePlayer:Function;
      
      public function TProcessorWindowSlaveRescue(param1:TUIComponent)
      {
         super(param1);
         this.FUIItems = new Vector.<TUIArrestItem>();
         this.FUIPage = new TUIPage(this);
         this.FCurrentList = new Vector.<Object>();
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
         var _loc4_:TextField = null;
         var _loc5_:TUIArrestItem = null;
         this.FMC_Rescue = TUtilityReflection.CreateDisplayObjectInstance(CONST_SLAVE.RESOURCE_ClassName_MC_Rescue) as Sprite;
         addChild(this.FMC_Rescue);
         this.FBTN_Close = this.FMC_Rescue[CONST_SLAVE.RESOURCE_Link_BTN_Close];
         this.FTF_Tittle = this.FMC_Rescue[CONST_SLAVE.RESOURCE_Link_TF_Tittle];
         this.FMC_RescuePlayers = this.FMC_Rescue[CONST_SLAVE.RESOURCE_Link_MC_RescuePlayers];
         this.FTF_DynamicTittle = this.FMC_RescuePlayers[CONST_SLAVE.RESOURCE_Link_TF_DynamicTittle];
         this.FMC_Nobody = this.FMC_Rescue[CONST_SLAVE.RESOURCE_Link_MC_Nobody];
         this.FTF_Nobody = this.FMC_Nobody[CONST_SLAVE.RESOURCE_Link_TF_Nobody];
         this.FTF_Explanation = this.FMC_Rescue[CONST_SLAVE.RESOURCE_Link_TF_Explanation];
         _loc2_ = this.Capacity_RescueItems;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc5_ = new TUIArrestItem(this);
            _loc5_.Resource = this.FMC_RescuePlayers[CONST_SLAVE.RESOURCE_Link_MC_Disciple + _loc1_];
            _loc5_.OnDynamicFunction = this.ProcessorOnRescuePlayer;
            _loc5_.Init();
            this.FUIItems[_loc1_] = _loc5_;
            _loc1_++;
         }
         _loc3_ = this.FMC_Rescue[CONST_SLAVE.RESOURCE_Link_MC_PageLeft];
         this.FUIPage.ButtonPrevious.Substrate = _loc3_;
         _loc3_ = this.FMC_Rescue[CONST_SLAVE.RESOURCE_Link_MC_PageRight];
         this.FUIPage.ButtonNext.Substrate = _loc3_;
         _loc4_ = this.FMC_Rescue[CONST_SLAVE.RESOURCE_Link_TF_Page];
         this.FUIPage.LabelPage = _loc4_;
         _loc4_.text = "0/0";
         this.FUIPage.PageSize = this.Capacity_RescueItems;
         this.FUIPage.Init();
         this.FUIPage.OnChangePage = this.PageOnChange;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.BTNCloseOnClick,false,0,true);
         super.ResourcesPerform_UILocations();
      }
      
      protected function FilterRescue() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TRescuePlayer = null;
         var _loc4_:TRescue = null;
         var _loc5_:TSOSPlayer = null;
         var _loc6_:TSOS = null;
         var _loc7_:TSystemLanguage = null;
         _loc2_ = this.FCurrentList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FCurrentList.pop();
            _loc1_++;
         }
         this.FMC_Nobody.visible = false;
         if(this.FObj is TRescue)
         {
            _loc4_ = this.FObj as TRescue;
            _loc2_ = _loc4_.RescueList.length;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc3_ = _loc4_.RescueList[_loc1_];
               this.FCurrentList.push(_loc3_);
               _loc1_++;
            }
            this.FTF_DynamicTittle.text = STRING_Mentorship.STRING_MasterName;
         }
         else if(this.FObj is TSOS)
         {
            _loc6_ = this.FObj as TSOS;
            _loc2_ = _loc6_.SOSList.length;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc5_ = _loc6_.SOSList[_loc1_];
               this.FCurrentList.push(_loc5_);
               _loc1_++;
            }
            this.FTF_DynamicTittle.text = STRING_Mentorship.STRING_GuildName;
         }
         if(this.FCurrentList.length == 0)
         {
            this.FMC_Nobody.visible = true;
            if(this.FObj is TRescue)
            {
               _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.NO_SLAVE_MEMBERSLAVE) as TSystemLanguage;
               this.FTF_Nobody.text = _loc7_.Desc;
            }
            else if(this.FObj is TSOS)
            {
               _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.NO_SLAVE_HELPER) as TSystemLanguage;
               this.FTF_Nobody.text = _loc7_.Desc;
            }
         }
      }
      
      protected function UpdateTittle() : void
      {
         if(this.FObj is TRescue)
         {
            this.FTF_Tittle.text = STRING_Mentorship.COMMAND_RescueMember;
         }
         else
         {
            this.FTF_Tittle.text = STRING_Mentorship.COMMAND_SOS;
         }
      }
      
      protected function UpdatePageInfo() : void
      {
         this.FPageIndex = 0;
         this.FUIPage.TotalQuantity = this.FCurrentList.length;
         this.FUIPage.PageIndex = this.FPageIndex;
         this.FUIPage.Update();
      }
      
      protected function UpdateRescueItemsInfo() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TUIArrestItem = null;
         _loc2_ = this.FCurrentList.length;
         _loc3_ = this.Capacity_RescueItems;
         _loc4_ = _loc2_ - this.FPageIndex * _loc3_;
         if(_loc2_ <= 0)
         {
            this.FMC_RescuePlayers.visible = false;
            this.FMC_Nobody.visible = true;
            return;
         }
         this.FMC_RescuePlayers.visible = true;
         this.FMC_Nobody.visible = false;
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
            _loc5_.Update(this.FCurrentList[_loc1_ + this.FPageIndex * _loc3_]);
            _loc5_.Resource.visible = true;
            _loc1_++;
         }
      }
      
      protected function UpdateExplanation() : void
      {
         if(this.FObj is TRescue)
         {
            this.FTF_Explanation.text = TUtilityString.GetText(CONST_SYSTEMLANGUAGE.STRING_Rescue);
         }
         else
         {
            this.FTF_Explanation.text = TUtilityString.GetText(CONST_SYSTEMLANGUAGE.STRING_SOS);
         }
      }
      
      protected function BTNCloseOnClick(param1:MouseEvent) : void
      {
         ProcessorWindowClose();
      }
      
      protected function ProcessorOnRescuePlayer(param1:Object, param2:Object) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:TRescuePlayer = null;
         var _loc5_:TSOSPlayer = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         if(param2 is TRescuePlayer)
         {
            _loc3_ = CONST_SLAVE.COMMAND_Rescue;
            _loc4_ = param2 as TRescuePlayer;
            _loc6_ = _loc4_.Identifier0;
            _loc7_ = _loc4_.Identifier1;
         }
         else if(param2 is TSOSPlayer)
         {
            _loc3_ = CONST_SLAVE.COMMAND_SOS;
            _loc5_ = param2 as TSOSPlayer;
            _loc6_ = _loc5_.Identifier0;
            _loc7_ = _loc5_.Identifier1;
         }
         if(this.FOnRescuePlayer != null)
         {
            this.FOnRescuePlayer(this,_loc3_,0,_loc6_,_loc7_);
         }
      }
      
      protected function PageOnChange(param1:Object, param2:int) : void
      {
         this.FPageIndex = param2;
         this.UpdateRescueItemsInfo();
      }
      
      public function get OnRescuePlayer() : Function
      {
         return this.FOnRescuePlayer;
      }
      
      public function set OnRescuePlayer(param1:Function) : void
      {
         this.FOnRescuePlayer = param1;
      }
      
      public function UpdateUI(param1:Object) : void
      {
         this.FObj = param1;
         this.FilterRescue();
         this.UpdatePageInfo();
         this.UpdateTittle();
         this.UpdateRescueItemsInfo();
         this.UpdateExplanation();
      }
   }
}

