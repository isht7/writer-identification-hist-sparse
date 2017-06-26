function [strokes,count] = DocRead(file)

        s=xml2struct(file);
        a = length(s.WhiteboardCaptureSession.StrokeSet.Stroke);
        count = 0;
        A = 0;
        
        for i = 1:(a-1)
            
            e = str2double(s.WhiteboardCaptureSession.StrokeSet.Stroke{1,i}.Attributes.end_time);
            f = str2double(s.WhiteboardCaptureSession.StrokeSet.Stroke{1,i+1}.Attributes.start_time);
            if (f-e)>=0.03
                count = count + 1;
                A = [A i];
            end
        end
        
        count = count + 1;
        A = [A length(s.WhiteboardCaptureSession.StrokeSet.Stroke)];
        strokes = cell(count,1);
        
        for i = 2:count+1
            b = 0;
            j = 0;
            for k = (A(i-1)+1):A(i)
                b = b + length(s.WhiteboardCaptureSession.StrokeSet.Stroke{1,k}.Point);
            end
            str = zeros(b,3);
            for k = (A(i-1)+1):A(i)
                r = 0;
                j = j+1;
                for j = j:j+length(s.WhiteboardCaptureSession.StrokeSet.Stroke{1,k}.Point)-1
                    
                    if length(s.WhiteboardCaptureSession.StrokeSet.Stroke{1,k}.Point) == 1
                        
                        str(1,1)= str2double(s.WhiteboardCaptureSession.StrokeSet.Stroke{1,k}.Point.Attributes.x);
                        str(1,2)= str2double(s.WhiteboardCaptureSession.StrokeSet.Stroke{1,k}.Point.Attributes.y);
                        str(1,3)= str2double(s.WhiteboardCaptureSession.StrokeSet.Stroke{1,k}.Point.Attributes.time);
                        
                    else
                        
                        r = r+1;
                        str(j,1)= str2double(s.WhiteboardCaptureSession.StrokeSet.Stroke{1,k}.Point{1,r}.Attributes.x);
                        str(j,2)= str2double(s.WhiteboardCaptureSession.StrokeSet.Stroke{1,k}.Point{1,r}.Attributes.y);
                        str(j,3)= str2double(s.WhiteboardCaptureSession.StrokeSet.Stroke{1,k}.Point{1,r}.Attributes.time);
                        
                        
                    end
                end
                
            end
            
            strokes{i-1} = str;
            
        end
end