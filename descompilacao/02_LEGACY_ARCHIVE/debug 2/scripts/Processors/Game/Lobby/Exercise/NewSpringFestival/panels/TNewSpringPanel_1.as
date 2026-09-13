package Processors.Game.Lobby.Exercise.NewSpringFestival.panels
{
   import Foundation.UI.TUIComponent;
   import Logics.DatebaseVO.VO.TNewSpring2018Config2;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.NewSpringFestival.TProcessorNewSpringFestival;
   import Processors.Game.Lobby.Exercise.NewSpringFestival.items.TNewSpringTaskInfoItem;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TNewSpringPanel_1 extends TUIBaseWindow
   {
      
      private const BOX_COUNT:int = 2;
      
      private const TASK_COUNT:int = 6;
      
      private var _main:TProcessorNewSpringFestival;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      private var keyBoxItem:Object;
      
      private var taskItems:Array;
      
      public function TNewSpringPanel_1(param1:TUIComponent)
      {
         super(param1);
         this._main = param1 as TProcessorNewSpringFestival;
         this.FBoxList = new Vector.<MovieClip>(this.BOX_COUNT);
      }
      
      private function initUi() : void
      {
         var _loc2_:MovieClip = null;
         var _loc4_:TNewSpringTaskInfoItem = null;
         var _loc1_:TNewSpring2018Config2 = this._main.tabConfig2.GetDatebaseByIdentifier(60001) as TNewSpring2018Config2;
         (FMC_Scene["t_needValue_0"] as TextField).text = int(_loc1_.dadao).toString();
         _loc1_ = this._main.tabConfig2.GetDatebaseByIdentifier(60002) as TNewSpring2018Config2;
         (FMC_Scene["t_needValue_1"] as TextField).text = int(_loc1_.dadao).toString();
         this.keyBoxItem = new Object();
         var _loc3_:int = 0;
         while(_loc3_ < this.BOX_COUNT)
         {
            _loc2_ = FMC_Scene["mc_giftBox_" + _loc3_.toString()] as MovieClip;
            this.keyBoxItem[_loc2_.name] = _loc3_;
            _loc2_.buttonMode = true;
            _loc2_.addEventListener(MouseEvent.CLICK,this.onGetRewardsHandler);
            (_loc2_["mc_lingqu"] as MovieClip).mouseEnabled = false;
            (_loc2_["mc_lingqu"] as MovieClip).mouseChildren = false;
            (_loc2_["mc_lingqu"] as MovieClip).visible = false;
            _loc3_++;
         }
         this.taskItems = [];
         var _loc5_:int = 0;
         while(_loc5_ < this.TASK_COUNT)
         {
            _loc4_ = new TNewSpringTaskInfoItem(this,this._main);
            _loc4_.initUI(FMC_Scene["mc_taskInfo_" + _loc5_.toString()],_loc5_);
            this.taskItems.push(_loc4_);
            _loc5_++;
         }
      }
      
      private function onGetRewardsHandler(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         var _loc3_:int = int(this.keyBoxItem[_loc2_.name]);
         if(_loc2_.currentFrame == 1)
         {
            return;
         }
         if(_loc3_ == 0 && this._main.newSpring2018Data.boxFlag1 == 1)
         {
            return;
         }
         if(_loc3_ == 1 && this._main.newSpring2018Data.boxFlag2 == 1)
         {
            return;
         }
         var _loc4_:Vector.<int> = new Vector.<int>();
         _loc4_.push(_loc3_);
         this._main.Packet_CS_AllReq(TProcessorNewSpringFestival.GET_BOX,_loc4_);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         super.Resources_UIDispatch(param1);
      }
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
         this.initUi();
      }
      
      override public function LogicsPerform() : void
      {
      }
      
      override public function UpdateUI() : void
      {
         var _loc1_:TNewSpringTaskInfoItem = null;
         var _loc3_:MovieClip = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.TASK_COUNT)
         {
            _loc1_ = this.taskItems[_loc2_] as TNewSpringTaskInfoItem;
            _loc1_.updateUI();
            _loc2_++;
         }
         (FMC_Scene["t_taskValue"] as TextField).text = this._main.newSpring2018Data.taskPoint.toString();
         if(this._main.newSpring2018Data.boxFlag1 == 1)
         {
            _loc3_ = FMC_Scene["mc_giftBox_0"]["mc_lingqu"] as MovieClip;
            _loc3_.visible = true;
         }
         if(this._main.newSpring2018Data.boxFlag2 == 1)
         {
            _loc3_ = FMC_Scene["mc_giftBox_1"]["mc_lingqu"] as MovieClip;
            _loc3_.visible = true;
         }
         var _loc4_:int = int(this._main.tabConfig2.GetDatebaseByIdentifier(60001)["dadao"]);
         if(this._main.newSpring2018Data.taskPoint >= _loc4_)
         {
            _loc3_ = FMC_Scene["mc_giftBox_0"] as MovieClip;
            _loc3_.gotoAndStop(2);
         }
         _loc4_ = int(this._main.tabConfig2.GetDatebaseByIdentifier(60002)["dadao"]);
         if(this._main.newSpring2018Data.taskPoint >= _loc4_)
         {
            _loc3_ = FMC_Scene["mc_giftBox_1"] as MovieClip;
            _loc3_.gotoAndStop(2);
         }
      }
   }
}

