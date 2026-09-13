package Processors.Game.Lobby.Exercise.FirstRechange_new
{
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Logics.DatebaseVO.VO.TheFirstRecharge;
   import Logics.Exercise.FirstRechange_new.TFirstRechange_new_Model;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Exercise.FirstRechange_new.eve.DatasEvent;
   import Processors.Game.Lobby.Exercise.FirstRechange_new.eve.FirstRechargeEventTypeName;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_FIRSTRECHAGE_NEW;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorFirstRecharge_New extends TProcessorBaseActivity
   {
      
      private var _mc_scroll:MovieClip;
      
      private var _leftPanel:FirstRechargeLeftPanel;
      
      private var _rightPanel:FirstRechargeRightPanel;
      
      private var _model:TFirstRechange_new_Model = SLogicsCore.FirstRechangeNewModel;
      
      private var tempData:Object;
      
      public function TProcessorFirstRecharge_New(param1:TUIComponent, param2:TLobbyParameters, param3:int)
      {
         super(param1,param2,param3);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         super.ResourcesPerform_UIDispatch();
         this._mc_scroll = FMC_Scene.mc_scroll;
         this._mc_scroll.visible = false;
         var _loc1_:MovieClip = FMC_Scene[CONST_FIRSTRECHAGE_NEW.RESOURCE_LEFT_PANEL];
         this._leftPanel = new FirstRechargeLeftPanel(this,_loc1_,this.viewHandler,this._model.firstRechangeResInfo);
         this._leftPanel.setMouseCoordinate(FUICore.MouseCoordinate);
         var _loc2_:MovieClip = FMC_Scene[CONST_FIRSTRECHAGE_NEW.RESOURCE_RIGHT_PANEL];
         this._rightPanel = new FirstRechargeRightPanel(this,_loc2_,this.viewHandler,this._model.firstRechangeResInfo);
         this._rightPanel.setMouseCoordinate(FUICore.MouseCoordinate);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         super.PacketRegisterRoutines();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(Boolean(this._leftPanel) && this.visible)
         {
            this._leftPanel.updateSlotList();
         }
         if(Boolean(this._rightPanel) && this.visible)
         {
            this._rightPanel.updateSlotList();
            this._rightPanel.LogicsPerform();
         }
      }
      
      override protected function ProcessorOnOpenDesc(param1:MouseEvent = null) : void
      {
         var _loc2_:TheFirstRecharge = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_TheFirstRecharge,50000) as TheFirstRecharge;
         FProcessorWindowDesc.BaseActivity = this._model;
         this._model.ActivityDesc = _loc2_.Fdesc;
         super.ProcessorOnOpenDesc(null);
      }
      
      private function closeViewHandler(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      private function viewHandler(param1:DatasEvent) : void
      {
         var _loc2_:Vector.<int> = null;
         switch(param1.type)
         {
            case FirstRechargeEventTypeName.CLICK_RECHARGE_BTN:
               ProcessorOnRechargeUp();
               break;
            case FirstRechargeEventTypeName.CLICK_FIRST_RECHARGE_GET_REWARD_BTN:
               this.tempData = {
                  "type":1,
                  "data":null
               };
               PerformPacket_CS_AllReq(1);
               break;
            case FirstRechargeEventTypeName.CLICK_MORE_RECHANGE_GET_REWARD_BTN:
               this.tempData = {
                  "type":2,
                  "data":int(param1.data)
               };
               _loc2_ = new <int>[int(param1.data)];
               PerformPacket_CS_AllReq(2,_loc2_);
               break;
            case FirstRechargeEventTypeName.CLICK_ACTIVITY_REWARD_BTN:
               this.tempData = {
                  "type":3,
                  "data":int(param1.data)
               };
               _loc2_ = new <int>[int(param1.data)];
               PerformPacket_CS_AllReq(3,_loc2_);
               break;
            case FirstRechargeEventTypeName.CLICK_MORE_ACTIVITY_REWARD_BTN:
               this.tempData = {
                  "type":4,
                  "data":null
               };
               PerformPacket_CS_AllReq(4);
               break;
            case FirstRechargeEventTypeName.CLOSE_RIGHT_VIEW:
               FBounds.Width = 692;
               FBounds.Height = 545;
               ComponentBoundsCenter(this,FBounds);
               this._mc_scroll.visible = true;
               this._rightPanel.destroy();
               this._rightPanel = null;
               break;
            case FirstRechargeEventTypeName.SHOW_BAG_TIP:
            case FirstRechargeEventTypeName.MOVE_BAG_TIP:
               ProcessorOnNewBoxOver(TInventories(param1.data));
               break;
            case FirstRechargeEventTypeName.HIDE_BAG_TIP:
               ProcessorOnNewBoxOut();
               break;
            case FirstRechargeEventTypeName.GET_ACTIVITY_INFO:
               this.ProcessorOnOpenDesc();
         }
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.visible = true;
         PerformPacket_CS_LoadInfoReq();
         SetInterval();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
      }
      
      override public function ProcessorOnLoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         super.ProcessorOnLoadInfoRet();
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this._model.firstRechangeResInfo.Unstreamize(_loc2_,this._model.firstRechangeResInfo,null);
         if(FIsResourcesLoadCompleted == false || this.visible == false)
         {
            return;
         }
         if(this._leftPanel == null && this._rightPanel == null)
         {
            return;
         }
         if(this._leftPanel)
         {
            this._leftPanel.updateView();
         }
         if(this._rightPanel)
         {
            if(this._model.firstRechangeResInfo.groupRechareShowStatus == 1)
            {
               this._rightPanel.destroy();
               this._rightPanel = null;
               FBounds.Width = 652;
               FBounds.Height = 545;
               ComponentBoundsCenter(this,FBounds);
               this._mc_scroll.visible = true;
            }
            else
            {
               this._rightPanel.updateView();
            }
         }
      }
      
      override public function ProcessorAllRet(param1:TPacket = null) : void
      {
         super.ProcessorAllRet();
         var _loc2_:ByteArray = param1.Data;
         var _loc3_:int = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         var _loc4_:int = _loc2_.readInt();
         var _loc5_:int = _loc2_.readShort();
         var _loc6_:Array = [];
         var _loc7_:int = 0;
         while(_loc7_ < _loc5_)
         {
            _loc6_.push(_loc2_.readInt());
            _loc7_++;
         }
         if(_loc4_ == 3 || _loc4_ == 4)
         {
            this._model.firstRechangeResInfo.groupRechareShowStatus = _loc6_[_loc6_.length - 1];
         }
         if(this.tempData.type == 1)
         {
            this._model.firstRechangeResInfo.firstRechareStatus = -1;
         }
         else if(this.tempData.type == 2)
         {
            this._model.firstRechangeResInfo.assupRechargeStatus[this.tempData.data - 1] = -1;
         }
         else if(this.tempData.type == 3)
         {
            this._model.firstRechangeResInfo.groupRechargeStauts[this.tempData.data - 1] = -1;
         }
         else if(this.tempData.type == 4)
         {
            this._model.firstRechangeResInfo.maxGroupRechargeStatus = -1;
         }
         EffectGenerateText(STRING_BASEACTIVITY.FORMAT_GET);
         if(this._leftPanel)
         {
            this._leftPanel.updateView();
         }
         if(this._rightPanel)
         {
            if(this._model.firstRechangeResInfo.groupRechareShowStatus == 1)
            {
               this._rightPanel.closeingView();
            }
            else
            {
               this._rightPanel.updateView();
            }
         }
         if(this._model.haveAddupReward() == false && this._model.firstRechangeResInfo.groupRechareShowStatus == 1)
         {
            this._leftPanel.destroy();
            this._leftPanel = null;
            this._mc_scroll.visible = false;
            ProcessorCloseActivity();
         }
      }
      
      override public function ProcessorChangeGold(param1:TPacket = null) : void
      {
         PerformPacket_CS_LoadInfoReq();
      }
   }
}

