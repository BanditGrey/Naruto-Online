package Processors.Game.Lobby.EightDoor.LittleClass
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TEightInnerGates_Attr;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_EIGHTDOOR;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TMainPointCell
   {
      
      protected var FThisPanl:MovieClip = null;
      
      protected var FMC_JieZhi:MovieClip = null;
      
      protected var FTF_PropertyName:TextField;
      
      protected var FTF_PropertyDec:TextField;
      
      protected var FMC_OpenPropertyBtn:MovieClip;
      
      protected var FCurData:TEightInnerGates_Attr;
      
      protected var FMC_Effect:MovieClip = null;
      
      protected var FBackFun:Function;
      
      protected var FBackFunOver:Function;
      
      protected var FBackFunOut:Function;
      
      protected var FBackFunMove:Function;
      
      public function TMainPointCell()
      {
         super();
      }
      
      public function set SetPanel(param1:MovieClip) : void
      {
         this.FThisPanl = param1;
         this.FMC_JieZhi = this.FThisPanl["MC_JieZhi"];
         this.FTF_PropertyName = this.FMC_JieZhi["TF_PropertyName"];
         this.FTF_PropertyDec = this.FMC_JieZhi["TF_PropertyDec"];
         this.FMC_JieZhi.mouseChildren = false;
         this.FMC_JieZhi.mouseEnabled = false;
         this.FThisPanl.addEventListener(MouseEvent.CLICK,this.HandleClick);
         this.FThisPanl.addEventListener(MouseEvent.MOUSE_OVER,this.HandleOver);
         this.FThisPanl.addEventListener(MouseEvent.MOUSE_OUT,this.HandleOut);
         this.FThisPanl.addEventListener(MouseEvent.MOUSE_MOVE,this.HandleMove);
      }
      
      public function Update() : void
      {
         var _loc1_:int = 0;
         var _loc3_:Array = null;
         var _loc4_:TArticle = null;
         var _loc2_:String = "";
         _loc1_ = 0;
         while(_loc1_ < this.FCurData.AddAttrArr.length)
         {
            _loc3_ = this.FCurData.AddAttrArr[_loc1_];
            _loc2_ += STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[CONST_COMMON.BASEATTRIBUTENAMES.indexOf(_loc3_[0])] + " +" + _loc3_[1] + "\n";
            _loc1_++;
         }
         this.FTF_PropertyName.text = _loc2_;
         this.StopPlay();
         this.FMC_JieZhi.visible = false;
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,SLogicsCore.EightDoorLogicData.TianShiId) as TArticle;
         this.FTF_PropertyDec.text = TUtilityString.Format(STRING_EIGHTDOOR.str16,this.FCurData.Consumption,_loc4_.Name);
         if(SLogicsCore.EightDoorLogicData.OpenedLastId == 0)
         {
            if(this.FCurData.Identifier == 10000001)
            {
               this.FThisPanl.gotoAndStop(2);
               this.FMC_OpenPropertyBtn = this.FThisPanl["MC_OpenPropertyBtn"];
               this.FMC_OpenPropertyBtn.buttonMode = true;
               this.FMC_JieZhi.visible = true;
            }
            else
            {
               this.FThisPanl.gotoAndStop(1);
               this.FMC_OpenPropertyBtn = this.FThisPanl["MC_OpenPropertyBtn"];
               this.FMC_OpenPropertyBtn.buttonMode = false;
            }
         }
         else if(SLogicsCore.EightDoorLogicData.OpenedLastId >= this.FCurData.Identifier)
         {
            this.FThisPanl.gotoAndStop(3);
            this.FMC_OpenPropertyBtn = this.FThisPanl["MC_OpenPropertyBtn"];
            this.FMC_Effect = this.FMC_OpenPropertyBtn["MC_Effect"];
            this.FMC_OpenPropertyBtn.buttonMode = false;
            this.FMC_OpenPropertyBtn.play();
            this.FMC_Effect.play();
         }
         else
         {
            this.FThisPanl.gotoAndStop(1);
            this.FMC_OpenPropertyBtn = this.FThisPanl["MC_OpenPropertyBtn"];
            this.FMC_OpenPropertyBtn.buttonMode = false;
            if(SLogicsCore.EightDoorLogicData.OpenedLastId + 1 == this.FCurData.Identifier)
            {
               this.FThisPanl.gotoAndStop(2);
               this.FMC_OpenPropertyBtn = this.FThisPanl["MC_OpenPropertyBtn"];
               this.FMC_OpenPropertyBtn.buttonMode = true;
               this.FMC_JieZhi.visible = true;
            }
         }
      }
      
      protected function StopPlay() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            this.FThisPanl.gotoAndStop(_loc1_ + 1);
            this.FMC_OpenPropertyBtn = this.FThisPanl["MC_OpenPropertyBtn"];
            this.FMC_Effect = this.FMC_OpenPropertyBtn["MC_Effect"];
            this.FMC_OpenPropertyBtn.gotoAndStop(1);
            if(this.FMC_Effect)
            {
               this.FMC_Effect.gotoAndStop(1);
            }
            _loc1_++;
         }
      }
      
      protected function HandleClick(param1:MouseEvent) : void
      {
         if(this.FMC_OpenPropertyBtn.buttonMode)
         {
            this.FBackFun(this.FCurData);
         }
      }
      
      protected function HandleOver(param1:MouseEvent) : void
      {
         if(this.FThisPanl.currentFrame != 3)
         {
            return;
         }
         if(this.FBackFunOver != null)
         {
            this.FBackFunOver(this.FCurData);
         }
      }
      
      protected function HandleOut(param1:MouseEvent) : void
      {
         if(this.FThisPanl.currentFrame != 3)
         {
            return;
         }
         if(this.FBackFunOut != null)
         {
            this.FBackFunOut();
         }
      }
      
      protected function HandleMove(param1:MouseEvent) : void
      {
         if(this.FThisPanl.currentFrame != 3)
         {
            return;
         }
         if(this.FBackFunMove != null)
         {
            this.FBackFunMove();
         }
      }
      
      public function set BackFunOver(param1:Function) : void
      {
         this.FBackFunOver = param1;
      }
      
      public function set BackFunOut(param1:Function) : void
      {
         this.FBackFunOut = param1;
      }
      
      public function set BackFunMove(param1:Function) : void
      {
         this.FBackFunMove = param1;
      }
      
      public function get BackFun() : Function
      {
         return this.FBackFun;
      }
      
      public function set BackFun(param1:Function) : void
      {
         this.FBackFun = param1;
      }
      
      public function set SetData(param1:TEightInnerGates_Attr) : void
      {
         this.FCurData = param1;
      }
   }
}

