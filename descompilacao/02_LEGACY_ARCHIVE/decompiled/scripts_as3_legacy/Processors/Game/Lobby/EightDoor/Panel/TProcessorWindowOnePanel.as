package Processors.Game.Lobby.EightDoor.Panel
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TEightInnerGates_Attr;
   import Logics.DatebaseVO.VO.TEightInnerGates_Mission;
   import Logics.DatebaseVO.VO.THeroTalent;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.EightDoor.LittleClass.TEightDoorCell;
   import Processors.Game.Lobby.EightDoor.LittleClass.TMainPointCell;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_EIGHTDOOR;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowOnePanel
   {
      
      public static const EIGHT:int = 8;
      
      public static const SEVEN:int = 8;
      
      protected var FThisPanel:MovieClip = null;
      
      protected var FBTN_Left:MovieClip = null;
      
      protected var FBTN_Right:MovieClip = null;
      
      protected var FTF_Doordec:TextField = null;
      
      protected var FMC_Image:MovieClip = null;
      
      protected var FTF_MainName:TextField = null;
      
      protected var FTF_LittleName:TextField = null;
      
      protected var FMC_FangAnOne:MovieClip = null;
      
      protected var FMC_FangAnTwo:MovieClip = null;
      
      protected var FTF_DoorPropertydec:TextField = null;
      
      protected var FTF_DoorPropertydec1:TextField = null;
      
      protected var FTF_PropertyDec:TextField = null;
      
      protected var FTF_StoreName:TextField = null;
      
      protected var FEightDoorCellVec:Vector.<TEightDoorCell>;
      
      protected var FMainPointCellVec:Vector.<TMainPointCell>;
      
      protected var HeroTalent:THeroTalent;
      
      protected var FEightDoorBins:TBins;
      
      protected var FEightDoorBins1:TBins;
      
      protected var FCurIndex:int;
      
      protected var FPageIndex:int;
      
      protected var FIsInitilization:Boolean;
      
      protected var FPointCellBack:Function;
      
      protected var FBackEightDoorMove:Function;
      
      protected var FBackEightDoorOver:Function;
      
      protected var FBackEightDoorOut:Function;
      
      protected var FBackMainPointOver:Function;
      
      protected var FBackMainPointOut:Function;
      
      protected var FBackMainPointMove:Function;
      
      public function TProcessorWindowOnePanel()
      {
         super();
         this.FEightDoorCellVec = new Vector.<TEightDoorCell>(EIGHT);
         this.FMainPointCellVec = new Vector.<TMainPointCell>(SEVEN);
      }
      
      public function set ThisPanel(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TEightInnerGates_Mission = null;
         var _loc4_:TEightInnerGates_Attr = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         this.FThisPanel = param1;
         this.FEightDoorBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_EightInnerGates_Mission);
         this.FEightDoorBins1 = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_EightInnerGates_Attr);
         _loc2_ = 0;
         while(_loc2_ < EIGHT)
         {
            _loc3_ = this.FEightDoorBins.GetDatebaseByIndex(_loc2_) as TEightInnerGates_Mission;
            this.FEightDoorCellVec[_loc2_] = new TEightDoorCell();
            if(_loc2_ == 0)
            {
               this.FEightDoorCellVec[_loc2_].ShangYiGeCell = null;
            }
            else
            {
               this.FEightDoorCellVec[_loc2_].ShangYiGeCell = this.FEightDoorCellVec[_loc2_ - 1];
            }
            this.FEightDoorCellVec[_loc2_].SetPanel(this.FThisPanel["MC_Door_" + _loc2_],_loc2_);
            this.FEightDoorCellVec[_loc2_].SetData = _loc3_;
            this.FEightDoorCellVec[_loc2_].BackClcik = this.EightDoorClick;
            this.FEightDoorCellVec[_loc2_].BackOver = this.EightDoorOver;
            this.FEightDoorCellVec[_loc2_].BackMove = this.EightDoorMove;
            this.FEightDoorCellVec[_loc2_].BackOut = this.EightDoorOut;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < SEVEN)
         {
            this.FMainPointCellVec[_loc2_] = new TMainPointCell();
            this.FMainPointCellVec[_loc2_].BackFunOver = this.MainPointOver;
            this.FMainPointCellVec[_loc2_].BackFunOut = this.MainPointOut;
            this.FMainPointCellVec[_loc2_].BackFunMove = this.MainPointMove;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < EIGHT)
         {
            this.FEightDoorCellVec[_loc2_].BaseDataVec.length = 0;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.FEightDoorBins1.Count)
         {
            _loc4_ = this.FEightDoorBins1.GetDatebaseByIndex(_loc2_) as TEightInnerGates_Attr;
            _loc5_ = _loc4_.MajorType.toString();
            _loc6_ = int(_loc5_.charAt(_loc5_.length - 1));
            this.FEightDoorCellVec[_loc6_ - 1].BaseDataVec.push(_loc4_);
            _loc2_++;
         }
         this.FMC_FangAnOne = this.FThisPanel["MC_FangAnOne"];
         this.FMC_FangAnTwo = this.FThisPanel["MC_FangAnTwo"];
         this.FBTN_Left = this.FThisPanel["BTN_Left"];
         this.FBTN_Right = this.FThisPanel["BTN_Right"];
         this.FBTN_Left.addEventListener(MouseEvent.CLICK,this.HandleCLICK);
         this.FBTN_Right.addEventListener(MouseEvent.CLICK,this.HandleCLICK);
         this.FTF_Doordec = this.FThisPanel["MC_Report"]["TF_Doordec"];
         this.FMC_Image = this.FThisPanel["MC_Report"]["MC_Image"];
         this.FTF_MainName = this.FThisPanel["TF_MainName"];
         this.FTF_LittleName = this.FThisPanel["TF_LittleName"];
         this.FTF_DoorPropertydec = this.FThisPanel["MC_Report"]["TF_DoorPropertydec"];
         this.FTF_DoorPropertydec.addEventListener(MouseEvent.MOUSE_OVER,this.DecOver);
         this.FTF_DoorPropertydec.addEventListener(MouseEvent.MOUSE_MOVE,this.DecMove);
         this.FTF_DoorPropertydec.addEventListener(MouseEvent.MOUSE_OUT,this.DecOut);
         this.FTF_DoorPropertydec1 = this.FThisPanel["MC_Report"]["TF_DoorPropertydec1"];
         this.FTF_PropertyDec = this.FThisPanel["TF_PropertyDec"];
         this.FTF_StoreName = this.FThisPanel["TF_StoreName"];
         this.FIsInitilization = true;
      }
      
      protected function MainPointCellBack(param1:TEightInnerGates_Attr) : void
      {
         if(this.FPointCellBack != null)
         {
            this.FPointCellBack(param1);
         }
      }
      
      protected function HandleCLICK(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FBTN_Left:
               if(!this.FBTN_Left.buttonMode)
               {
                  return;
               }
               --this.FPageIndex;
               this.UpdatePageIndex();
               this.UpdateMainPoint();
               break;
            case this.FBTN_Right:
               if(!this.FBTN_Right.buttonMode)
               {
                  return;
               }
               ++this.FPageIndex;
               this.UpdatePageIndex();
               this.UpdateMainPoint();
         }
      }
      
      protected function UpdatePageIndex() : void
      {
         if(this.FPageIndex < 0)
         {
            this.FPageIndex = 0;
         }
         else if(this.FPageIndex * SEVEN > this.FEightDoorCellVec[this.FCurIndex].BaseDataVec.length)
         {
            --this.FPageIndex;
         }
         TGameUtil.setButtonMode(this.FBTN_Left,this.FPageIndex <= 0 ? false : true);
         TGameUtil.setButtonMode(this.FBTN_Right,(this.FPageIndex + 1) * SEVEN >= this.FEightDoorCellVec[this.FCurIndex].BaseDataVec.length ? false : true);
      }
      
      public function set CurIndex(param1:int) : void
      {
         this.FCurIndex = param1;
      }
      
      public function UpdateReport() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Array = null;
         var _loc3_:String = "";
         this.FTF_Doordec.text = TUtilityString.Format(STRING_EIGHTDOOR.str1,this.FEightDoorCellVec[this.FCurIndex].EightInnerGates_Mission.Name,this.FEightDoorCellVec[this.FCurIndex].EightInnerGates_Mission.Name);
         this.FMC_Image.gotoAndStop(this.FEightDoorCellVec[this.FCurIndex].EightInnerGates_Mission.MajorType);
         this.FTF_MainName.text = this.FEightDoorCellVec[this.FCurIndex].EightInnerGates_Mission.Name;
         _loc2_ = this.FEightDoorCellVec[this.FCurIndex].EightInnerGates_Mission.AddAttrArr;
         _loc1_ = 0;
         while(_loc1_ < _loc2_.length)
         {
            if(Boolean(_loc2_[_loc1_]) && _loc2_[_loc1_].length > 0)
            {
               _loc3_ += STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[CONST_COMMON.BASEATTRIBUTENAMES.indexOf(_loc2_[_loc1_][0])] + " +" + _loc2_[_loc1_][1] + "\n";
            }
            else
            {
               _loc3_ += "";
            }
            _loc1_++;
         }
         this.HeroTalent = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_HeroTalent,this.FEightDoorCellVec[this.FCurIndex].EightInnerGates_Mission.MainHeroTalent) as THeroTalent;
         this.FTF_DoorPropertydec.text = this.HeroTalent.TalentName;
         this.FTF_DoorPropertydec1.text = _loc3_;
      }
      
      protected function AllClick(param1:MouseEvent) : void
      {
      }
      
      public function UpdateEightCell() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TEightInnerGates_Attr = null;
         var _loc4_:TArticle = null;
         if(SLogicsCore.EightDoorLogicData.OpenedLastId == 0)
         {
            this.FTF_LittleName.text = this.FEightDoorCellVec[this.FCurIndex].BaseDataVec[0].Name;
         }
         else
         {
            _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_EightInnerGates_Attr,SLogicsCore.EightDoorLogicData.OpenedLastId) as TEightInnerGates_Attr;
            this.FTF_LittleName.text = _loc3_.Name;
         }
         _loc1_ = 0;
         while(_loc1_ < EIGHT)
         {
            this.FEightDoorCellVec[_loc1_].Update();
            _loc1_++;
         }
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,SLogicsCore.EightDoorLogicData.TianShiId) as TArticle;
         this.FTF_StoreName.text = _loc4_.Name + ":";
         this.FTF_PropertyDec.text = SLogicsCore.EightDoorLogicData.GodStoreCount.toString();
         this.UpdateLabbel();
      }
      
      public function UpdateMainPoint() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.FMC_FangAnOne.visible = false;
         this.FMC_FangAnTwo.visible = false;
         var _loc3_:MovieClip = null;
         if(this.FEightDoorCellVec[this.FCurIndex].BaseDataVec[this.FPageIndex * SEVEN].Background == 1)
         {
            _loc3_ = this.FMC_FangAnOne;
         }
         else
         {
            _loc3_ = this.FMC_FangAnTwo;
         }
         _loc3_.visible = true;
         _loc1_ = 0;
         while(_loc1_ < SEVEN)
         {
            _loc2_ = this.FPageIndex * SEVEN + _loc1_;
            this.FMainPointCellVec[_loc1_].SetPanel = _loc3_["MC_MainPoint_" + _loc1_];
            this.FMainPointCellVec[_loc1_].BackFun = this.MainPointCellBack;
            this.FMainPointCellVec[_loc1_].SetData = this.FEightDoorCellVec[this.FCurIndex].BaseDataVec[_loc2_];
            this.FMainPointCellVec[_loc1_].Update();
            _loc1_++;
         }
      }
      
      protected function MainPointOver(param1:TEightInnerGates_Attr) : void
      {
         this.FBackMainPointOver(param1);
      }
      
      protected function MainPointOut() : void
      {
         this.FBackMainPointOut();
      }
      
      protected function MainPointMove() : void
      {
         this.FBackMainPointMove();
      }
      
      protected function DecOver(param1:MouseEvent) : void
      {
         this.FBackEightDoorOver(0,true,this.HeroTalent.TalentDesc);
      }
      
      protected function DecOut(param1:MouseEvent) : void
      {
         this.FBackEightDoorOut(0);
      }
      
      protected function DecMove(param1:MouseEvent) : void
      {
         this.FBackEightDoorMove(0);
      }
      
      protected function EightDoorOver(param1:int) : void
      {
         this.FBackEightDoorOver(param1);
      }
      
      protected function EightDoorOut(param1:int) : void
      {
         this.FBackEightDoorOut(param1);
      }
      
      protected function EightDoorMove(param1:int) : void
      {
         this.FBackEightDoorMove(param1);
      }
      
      protected function EightDoorClick(param1:int) : void
      {
         if(this.FCurIndex == param1)
         {
            return;
         }
         this.FCurIndex = param1;
         this.UpdateLabbel();
         this.UpdateByPage(0);
         this.UpdateMainPoint();
      }
      
      protected function UpdateLabbel() : void
      {
         if(!this.FEightDoorCellVec.length)
         {
            return;
         }
         var _loc1_:int = 0;
         while(_loc1_ < EIGHT)
         {
            this.FEightDoorCellVec[_loc1_].MC_Effect.visible = false;
            this.FEightDoorCellVec[_loc1_].MC_Effect.gotoAndStop(1);
            _loc1_++;
         }
         this.FEightDoorCellVec[this.FCurIndex].MC_Effect.visible = true;
         this.FEightDoorCellVec[this.FCurIndex].MC_Effect.play();
      }
      
      public function UpdateByPage(param1:int) : void
      {
         this.FPageIndex = param1;
         this.UpdatePageIndex();
         this.UpdateReport();
      }
      
      public function set BackMainPointOver(param1:Function) : void
      {
         this.FBackMainPointOver = param1;
      }
      
      public function set BackMainPointOut(param1:Function) : void
      {
         this.FBackMainPointOut = param1;
      }
      
      public function set BackMainPointMove(param1:Function) : void
      {
         this.FBackMainPointMove = param1;
      }
      
      public function set BackEightDoorMove(param1:Function) : void
      {
         this.FBackEightDoorMove = param1;
      }
      
      public function set BackEightDoorOver(param1:Function) : void
      {
         this.FBackEightDoorOver = param1;
      }
      
      public function set BackEightDoorOut(param1:Function) : void
      {
         this.FBackEightDoorOut = param1;
      }
      
      public function get EightDoorCellVec() : Vector.<TEightDoorCell>
      {
         return this.FEightDoorCellVec;
      }
      
      public function set PointCellBack(param1:Function) : void
      {
         this.FPointCellBack = param1;
      }
   }
}

