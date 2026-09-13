package Processors.Game.Lobby.TongLing.ToolS
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.UI.TUICore;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TBB_Status;
   import Logics.DatebaseVO.VO.TBB_Train;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_TONGLINGANIMAL;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TProcessorPeiYangMode extends TProcessorLobbyWindow
   {
      
      public static const COUNT:int = 3;
      
      public static const BASEINT:int = 10000;
      
      public static const BASE:int = 10;
      
      protected var FRootPanel:MovieClip;
      
      protected var VecTrains:Vector.<TBB_Train> = new Vector.<TBB_Train>(COUNT);
      
      protected var VecPeiYangs:Vector.<PeiYangUint> = new Vector.<PeiYangUint>(COUNT);
      
      protected var FCurPetId:int;
      
      protected var FCurCellIndex:int;
      
      protected var FBackFunction:Function;
      
      protected var FExteShow:Function;
      
      protected var FTempCore:TUICore;
      
      private var FSp:Sprite = new Sprite();
      
      protected var _curId:int = 0;
      
      protected var _level:int = 0;
      
      public function TProcessorPeiYangMode(param1:TUIComponent, param2:TUICore)
      {
         this.FTempCore = param2;
         super(param1);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TONGLINGANIMAL.TONGLING_ID);
         super.ResourcesPerform_UIRequest();
      }
      
      public function BeginDraw() : void
      {
         this.FSp.graphics.beginFill(0,0.3);
         this.FSp.graphics.drawRect(0,0,this.FTempCore.StageWidth,this.FTempCore.StageHeight);
         this.FSp.graphics.endFill();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:PeiYangUint = null;
         this.FRootPanel = TUtilityReflection.CreateDisplayObjectInstance(CONST_TONGLINGANIMAL.Select_Mod) as MovieClip;
         addChild(this.FSp);
         this.BeginDraw();
         this.FSp.x = this.FTempCore.StageWidth - this.FSp.width >> 1;
         this.FSp.y = this.FTempCore.StageHeight - this.FSp.height >> 1;
         this.FSp.addChild(this.FRootPanel);
         this.FRootPanel.x = this.FSp.width - this.FRootPanel.width >> 1;
         this.FRootPanel.y = this.FSp.height - this.FRootPanel.height >> 1;
         SimpleButton(this.FRootPanel[CONST_TONGLINGANIMAL.Select_Mod_close]).addEventListener(MouseEvent.CLICK,this.CloseBtn);
         var _loc2_:int = 0;
         while(_loc2_ < COUNT)
         {
            _loc1_ = new PeiYangUint(this.FRootPanel["MC_Item" + _loc2_]);
            _loc1_.BackFunction = this.AcceptFunction;
            _loc1_.ExteShow = this.TraceMsg;
            this.VecPeiYangs[_loc2_] = _loc1_;
            _loc2_++;
         }
         super.ResourcesPerform_UIDispatch();
      }
      
      public function SetMsg(param1:int, param2:int, param3:int) : void
      {
         this._curId = param1;
         this._level = param3;
         if(param1 == 0)
         {
            return;
         }
         this.FCurCellIndex = param2;
         var _loc4_:TBB_Status = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Status,param1) as TBB_Status;
         this.FCurPetId = _loc4_.Rarity;
         this.MakeValue();
         this.SetValue();
      }
      
      public function SetValue() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < COUNT)
         {
            this.VecPeiYangs[_loc1_].SetMsg(this.VecTrains[_loc1_],_loc1_ + 1,this.FCurCellIndex,this._curId,this._level);
            _loc1_++;
         }
      }
      
      public function UpdateP() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < COUNT)
         {
            if(this.VecPeiYangs[_loc1_] == null)
            {
               return;
            }
            this.VecPeiYangs[_loc1_].update();
            _loc1_++;
         }
      }
      
      public function MakeValue() : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBB_Train = null;
         var _loc1_:int = 0;
         while(_loc1_ < COUNT)
         {
            _loc2_ = BASEINT + this.FCurPetId * BASE + (_loc1_ + 1);
            _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Train,_loc2_) as TBB_Train;
            this.VecTrains[_loc1_] = _loc3_;
            _loc1_++;
         }
      }
      
      public function CloseBtn(param1:MouseEvent) : void
      {
         this.visible = false;
      }
      
      public function AcceptFunction(param1:Object) : void
      {
         this.FBackFunction(param1);
      }
      
      public function TraceMsg(param1:String) : void
      {
         this.FExteShow(param1);
      }
      
      public function get BackFunction() : Function
      {
         return this.FBackFunction;
      }
      
      public function set BackFunction(param1:Function) : void
      {
         this.FBackFunction = param1;
      }
      
      public function set ExteShow(param1:Function) : void
      {
         this.FExteShow = param1;
      }
   }
}

